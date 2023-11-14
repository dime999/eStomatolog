import 'dart:io';
import 'package:estomatolog_admin/models/Grad/grad.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Slika/slika_insert.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        SlikaInsert insert = SlikaInsert(widget.ordinacijaId, imageFile.path);
        var slikaProvider = Provider.of<SlikaProvider>(context, listen: false);

        await slikaProvider.insertSlikaOrdinacija(insert);
      } catch (e) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrdinacijaDetaljiScreen(
              ordinacijaId: ordinacija.ordinacijaId,
            ),
          ),
        );
      }
    }
  }

  Future<List<int>> fetchOrdinacijaSlike(BuildContext context) async {
    var ordinacijaSlikeProvider =
        Provider.of<SlikaProvider>(context, listen: false);
    var fetchedOrdinacije =
        await ordinacijaSlikeProvider.getSlikeIds(widget.ordinacijaId);
    return fetchedOrdinacije;
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

  TextEditingController nazivController = TextEditingController();
  TextEditingController adresaController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController gradController = TextEditingController();
  late OrdinacijaProvider _ordinacijaProvider;
  late SlikaProvider _slikaProvider;

  @override
  Widget build(BuildContext context) {
    _slikaProvider = Provider.of<SlikaProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ordinacija info"),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Osnovne informacije o ordinaciji:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFormField('Naziv', nazivController),
                                    const SizedBox(height: 16.0),
                                    _buildFormField('Adresa', adresaController),
                                    const SizedBox(height: 16.0),
                                    _buildFormField(
                                        'Telefon', telefonController),
                                    _buildFormFieldGrad(
                                        'Trenutni grad', gradController),
                                    const SizedBox(height: 16.0),
                                    _buildSingleSelectGrad(
                                        'Odaberi drugi grad', context),
                                    const SizedBox(height: 16.0),
                                    const SizedBox(height: 32.0),
                                    _buildSaveButton(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                FutureBuilder<List<int>>(
                                  future: fetchOrdinacijaSlike(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          'Greška prilikom dohvata ID-ova slika.');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text(
                                          'Nema dostupnih ID-ova slika.');
                                    } else {
                                      List<int> slikeIds = snapshot.data!;

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Image.network(
                                              "https://localhost:7265/SlikaStream?slikaId=${slikeIds[currentIndex]}",
                                              width: 400,
                                              height: 400,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex > 0) {
                                                    setState(() {
                                                      currentIndex--;
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                    'Prethodna slika'),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex <
                                                      slikeIds.length - 1) {
                                                    setState(() {
                                                      currentIndex++;
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                    'Sljedeća slika'),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  await _uploadImage();
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrdinacijaDetaljiScreen(
                                                      ordinacijaId: ordinacija
                                                          .ordinacijaId,
                                                    ),
                                                  );
                                                } catch (e) {
                                                  print(e);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 32.0,
                                                  vertical: 16.0,
                                                ),
                                              ),
                                              child: const Text(
                                                'Dodaj novu sliku',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Potvrda"),
                                                      content: const Text(
                                                          "Da li ste sigurni da želite izbrisati sliku?"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            try {
                                                              await _slikaProvider
                                                                  .delete(slikeIds[
                                                                      currentIndex]);

                                                              // ignore: use_build_context_synchronously
                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        "Potvrda"),
                                                                    content:
                                                                        const Text(
                                                                            "Uspješno ste izbrisali sliku!"),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () async {
                                                                          try {
                                                                            // ignore: use_build_context_synchronously

                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                          } on Exception catch (e) {
                                                                            print(e);
                                                                          }
                                                                        },
                                                                        child: const Text(
                                                                            "OK"),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            } on Exception catch (e) {
                                                              print(e);
                                                            }
                                                          },
                                                          child:
                                                              const Text("Da"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child:
                                                              const Text("Ne"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 32.0,
                                                    vertical: 16.0,
                                                  ),
                                                  backgroundColor: Colors.red),
                                              child: const Text(
                                                'Izbriši sliku',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]))));
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
        onPressed: () async {
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
                        Navigator.of(context).pop();
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
        },
        child: const Text('Spremi'),
      ),
    );
  }
}
