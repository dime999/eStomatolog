import 'package:estomatolog_admin/models/Grad/grad.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/validator.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/ordinacija_galerija.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ordinacija_provider.dart';

class OrdinacijaDetaljiScreen extends StatefulWidget {
  final int ordinacijaId;
  const OrdinacijaDetaljiScreen({super.key, required this.ordinacijaId});

  @override
  _OrdinacijaDetaljiScreenState createState() =>
      _OrdinacijaDetaljiScreenState();
}

class _OrdinacijaDetaljiScreenState extends State<OrdinacijaDetaljiScreen> {
  int currentIndex = 0;
  late Ordinacija ordinacija;
  List<int> idGradova = [];
  List<String> naziviGradova = [];
  List<Grad> gradovi = [];
  int odabraniGrad = 0;
  String? selectedValueGrad;
  late Grad defaultniGrad;

  @override
  void initState() {
    super.initState();
    fetchOrdinacija(context);
    fetchGradovi(context);
  }

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    ordinacija = await ordinacijaProvider.getById(widget.ordinacijaId);

    odabraniGrad = ordinacija.gradId;
    await fetchGrad(context, ordinacija.gradId);
    setState(() {
      nazivController.text = ordinacija.naziv;
      telefonController.text = ordinacija.telefon;
      adresaController.text = ordinacija.adresa;
      gradController.text = defaultniGrad.naziv!;
    });
    return ordinacija;
  }

  Future<List<Grad>> fetchGradovi(BuildContext context) async {
    var provider = Provider.of<GradProvider>(context, listen: false);
    var fetchedGradovi = await provider.get();
    naziviGradova =
        fetchedGradovi.result.map((grad) => grad.naziv ?? '').toList();
    idGradova = fetchedGradovi.result.map((grad) => grad.gradId ?? 0).toList();
    setState(() {
      gradovi = fetchedGradovi.result;
    });
    return gradovi;
  }

  Future<Grad> fetchGrad(BuildContext context, int id) async {
    var provider = Provider.of<GradProvider>(context, listen: false);
    defaultniGrad = await provider.getById(id);
    return defaultniGrad;
  }

  bool _isNazivValid = true;
  bool _isAdresaValid = true;
  bool _isTelefonValid = true;

  TextEditingController nazivController = TextEditingController();
  TextEditingController adresaController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController gradController = TextEditingController();
  late OrdinacijaProvider _ordinacijaProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ordinacija info"),
          centerTitle: true,
        ),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: nazivController,
                                    decoration: InputDecoration(
                                      labelText: "Naziv ordinacije",
                                      border: OutlineInputBorder(),
                                      errorText: _isNazivValid
                                          ? null
                                          : 'Unesite ispravne podatke za naziv',
                                    ),
                                    onChanged: (value) {
                                      bool isValid =
                                          Validators.validirajKorisnickoIme(
                                              value);
                                      setState(() {
                                        _isNazivValid = isValid;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    controller: adresaController,
                                    decoration: InputDecoration(
                                      labelText: "Adresa",
                                      border: OutlineInputBorder(),
                                      errorText: _isAdresaValid
                                          ? null
                                          : 'Unesite ispravne podatke za adresu',
                                    ),
                                    onChanged: (value) {
                                      bool isValid =
                                          Validators.validirajAdresu(value);
                                      setState(() {
                                        _isAdresaValid = isValid;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    controller: telefonController,
                                    decoration: InputDecoration(
                                      labelText: "Telefon",
                                      border: OutlineInputBorder(),
                                      errorText: _isTelefonValid
                                          ? null
                                          : 'Unesite ispravne podatke za telefon',
                                    ),
                                    onChanged: (value) {
                                      bool isValid =
                                          Validators.validirajBrojTelefona(
                                              value);
                                      setState(() {
                                        _isTelefonValid = isValid;
                                      });
                                    },
                                  ),
                                  _buildFormFieldGrad(
                                      'Trenutni grad', gradController),
                                  const SizedBox(height: 32.0),
                                  _buildSingleSelectGrad(
                                      'Odaberi drugi grad', context),
                                  const SizedBox(height: 16.0),
                                  _buildGalleryButton(context),
                                  const SizedBox(height: 16.0),
                                  _buildSaveButton(),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ],
                ))));
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFieldGrad(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            readOnly: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildSingleSelectGrad(String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 146, 140, 140),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                focusColor: Colors.white,
                isExpanded: true,
                hint: Text('Odaberite grad'),
                value: selectedValueGrad,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValueGrad = newValue!;

                    int indexOfSelectedGrad = naziviGradova.indexOf(newValue);
                    if (indexOfSelectedGrad != -1) {
                      odabraniGrad = idGradova[indexOfSelectedGrad];
                    }
                  });
                },
                items: naziviGradova.map((String grad) {
                  return DropdownMenuItem<String>(
                    value: grad,
                    child: Text(grad),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalleryButton(BuildContext context) {
    return SizedBox(
        width: 200.0,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrdinacijaGalerijaScreen(
                        ordinacijaId: widget.ordinacijaId,
                      )), // Replace GalleryScreen with your actual screen widget
            );
          },
          child: Text('Galerija ordinacije'),
        ));
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Obavijest'),
          content: Text('Uspješno ste uredili informacije ordinacije!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton() {
    _ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    Ordinacija updatedOrdinacija = Ordinacija(
      widget.ordinacijaId,
      nazivController.text,
      adresaController.text,
      telefonController.text,
      odabraniGrad,
    );
    return SizedBox(
      width: 200.0,
      child: ElevatedButton(
        onPressed: _isNazivValid && _isAdresaValid && _isTelefonValid
            ? () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Potvrda ažuriranja"),
                      content: const Text(
                          "Da li ste sigurni da želite ažurirati ordinaciju sa unesenim informacijama?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Otkaži"),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await _ordinacijaProvider.update(
                                  widget.ordinacijaId, updatedOrdinacija);
                              Navigator.of(context).pop();
                              showAlertDialog(context);
                            } catch (e) {
                              print("Greška prilikom ažuriranja: $e");
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text("Potvrdi"),
                        ),
                      ],
                    );
                  },
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // Set the background color to red
        ),
        child: const Text('Spremi'),
      ),
    );
  }
}
