import 'package:estomatolog_mobile/models/Grad/grad.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Korisnik/pacijent_insert.dart';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/models/validator.dart';
import 'package:estomatolog_mobile/providers/grad_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

class RegistracijaScreen extends StatefulWidget {
  const RegistracijaScreen({super.key});

  @override
  _RegistracijatScreenState createState() => _RegistracijatScreenState();
}

class _RegistracijatScreenState extends State<RegistracijaScreen> {
  List<int> idOrdinacija = [];
  List<String> naziviOrdinacija = [];
  List<Ordinacija> ordinacije = [];
  List<int> odabraneOrdinacije = [];

  List<int> idGradova = [];
  List<String> naziviGradova = [];
  List<Grad> gradovi = [];
  int odabraniGrad = 1;
  List<int> uloga = [2];
  late Korisnik korisnik;
  DateTime odabraniDatum = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchOrdinacije(context);
    fetchGradovi(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (pickedDate != DateTime.now()) {
      setState(() {
        odabraniDatum = pickedDate;
        datumRodjenjaController.text =
            DateFormat('dd.MM.yyyy').format(pickedDate);
      });
    }
  }

  Future<List<Ordinacija>> fetchOrdinacije(BuildContext context) async {
    var provider = Provider.of<OrdinacijaProvider>(context, listen: false);
    var fetchedOrdinacije = await provider.get();
    naziviOrdinacija =
        fetchedOrdinacije.result.map((ordinacija) => ordinacija.naziv).toList();

    idOrdinacija = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.ordinacijaId)
        .toList();
    setState(() {
      ordinacije = fetchedOrdinacije.result;
    });
    return ordinacije;
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

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController korisnickoImeController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController lozinkaController = TextEditingController();
  TextEditingController lozinkaPotvrdaController = TextEditingController();

  bool status = true;

  List<String> selectedValuesOrdinacije = [];
  String? selectedValueGrad;
  late KorisniciProvider _korisniciProvider;
  bool _isImeValid = true;
  bool _isPrezimeValid = true;
  bool _isTelefonValid = true;
  bool _isEmailValid = true;
  bool _isKorisnickoImeValid = true;
  bool _isLozinkaValid = true;
  bool _isLozinkaPotvrdaValid = true;

  @override
  Widget build(BuildContecon2text) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija korisnika'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lični podaci korisnika',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: imeController,
                          decoration: InputDecoration(
                            labelText: "Ime",
                            border: OutlineInputBorder(),
                            errorText: _isImeValid
                                ? null
                                : 'Unesite ispravne podatke za ime',
                          ),
                          onChanged: (value) {
                            bool isValid = Validators.validirajIme(value);
                            setState(() {
                              _isImeValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: prezimeController,
                          decoration: InputDecoration(
                            labelText: "Prezime",
                            border: OutlineInputBorder(),
                            errorText: _isPrezimeValid
                                ? null
                                : 'Unesite ispravne podatke za prezime',
                          ),
                          onChanged: (value) {
                            bool isValid = Validators.validirajPrezime(value);
                            setState(() {
                              _isPrezimeValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            errorText: _isEmailValid
                                ? null
                                : 'Unesite ispravne podatke za e-mail',
                          ),
                          onChanged: (value) {
                            bool isValid = Validators.validirajEmail(value);
                            setState(() {
                              _isEmailValid = isValid;
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
                                Validators.validirajBrojTelefona(value);
                            setState(() {
                              _isTelefonValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        _buildDateField(),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: korisnickoImeController,
                          decoration: InputDecoration(
                            labelText: "Korisničko ime",
                            border: OutlineInputBorder(),
                            errorText: _isKorisnickoImeValid
                                ? null
                                : 'Unesite ispravne podatke za korisničko ime',
                          ),
                          onChanged: (value) {
                            bool isValid =
                                Validators.validirajKorisnickoIme(value);
                            setState(() {
                              _isKorisnickoImeValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: lozinkaController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Lozinka",
                            border: OutlineInputBorder(),
                            errorText: _isLozinkaValid
                                ? null
                                : 'Lozinka mora biti minimalno 4 znaka',
                          ),
                          onChanged: (value) {
                            bool isValid = Validators.validirajLozinku(value);
                            setState(() {
                              _isLozinkaValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: lozinkaPotvrdaController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Lozinka potvrda",
                            border: OutlineInputBorder(),
                            errorText: _isLozinkaPotvrdaValid
                                ? null
                                : 'Lozinka mora biti minimalno 4 znaka',
                          ),
                          onChanged: (value) {
                            bool isValid = Validators.validirajLozinku(value);
                            setState(() {
                              _isLozinkaPotvrdaValid = isValid;
                            });
                          },
                        ),
                        const SizedBox(height: 32.0),
                        _buildStatusField(),
                        _buildMultiselectOrdinacije('Ordinacije', context),
                        const SizedBox(height: 32.0),
                        _buildSingleSelectGrad('Gradovi', context),
                        const SizedBox(height: 32.0),
                        _buildSaveButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: IgnorePointer(
        child: TextFormField(
          controller: datumRodjenjaController,
          decoration: InputDecoration(
            labelText: 'Datum rođenja',
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiselectOrdinacije(String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: DropDownMultiSelect(
            onChanged: (List<String> values) {
              setState(() {
                selectedValuesOrdinacije = values;
                odabraneOrdinacije = values
                    .map((value) =>
                        idOrdinacija[naziviOrdinacija.indexOf(value)])
                    .toList();
              });
            },
            options: naziviOrdinacija,
            selectedValues: selectedValuesOrdinacije,
            whenEmpty: 'Odaberite ordinacije',
          ),
        ),
      ],
    );
  }

  Widget _buildSingleSelectGrad(String label, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 146, 140, 140), width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButton<String>(
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
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusField() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Status'),
          const SizedBox(height: 8.0),
          Switch(
            value: status,
            onChanged: (newValue) {
              setState(() {
                status = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    PacijentInsertModel korisnik = PacijentInsertModel(
        imeController.text,
        prezimeController.text,
        emailController.text,
        telefonController.text,
        korisnickoImeController.text,
        status,
        odabraniGrad,
        uloga,
        odabraneOrdinacije,
        lozinkaController.text,
        lozinkaPotvrdaController.text,
        odabraniDatum);
    return SizedBox(
      width: 200.0,
      child: ElevatedButton(
        onPressed: selectedValuesOrdinacije.isNotEmpty &&
                selectedValueGrad != null &&
                _isImeValid &&
                _isPrezimeValid &&
                _isEmailValid &&
                _isKorisnickoImeValid &&
                _isTelefonValid &&
                _isLozinkaValid &&
                _isLozinkaPotvrdaValid
            ? () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Potvrda ažuriranja"),
                      content: const Text(
                          "Da li ste sigurni da želite dodati korisnika sa unesenim informacijama?"),
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
                              await _korisniciProvider.insertPacijent(korisnik);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } catch (e) {
                              print("Greška prilikom dodavanja: $e");
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
        child: const Text('Spremi'),
      ),
    );
  }
}
