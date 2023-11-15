import 'dart:io';

import 'package:estomatolog_admin/models/Doktor/doktor_slika_insert.dart';
import 'package:estomatolog_admin/models/Grad/grad.dart';
import 'package:estomatolog_admin/models/Korisnik/doktor_update.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija_info.dart';
import 'package:estomatolog_admin/models/Specijalizacija/doktorSpecijalizacija.dart';
import 'package:estomatolog_admin/models/Specijalizacija/specijalizacija.dart';
import 'package:estomatolog_admin/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/doktor_specijalizacija.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:estomatolog_admin/providers/specijalizacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

class EditDoctorScreen extends StatefulWidget {
  final int korisnikId;
  final int doktorId;

  const EditDoctorScreen(
      {super.key, required this.korisnikId, required this.doktorId});

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  List<int> idSpecijalizacija = [];
  List<String> naziviSpecijalizacija = [];
  List<Specijalizacija> specijalizacije = [];
  List<int> odabraneSpecijalizacije = [];

  List<DoktorSpecijalizacija> specijalizacijeDef = [];
  List<int> idSpecijalizacijaDef = [];
  List<String> naziviSpecijalizacijaDef = [];

  List<OrdinacijaInfo> ordinacijeDef = [];
  List<int> idOrdinacijaDef = [];
  List<String> naziviOrdinacijaDef = [];

  List<int> idOrdinacija = [];
  List<String> naziviOrdinacija = [];
  List<Ordinacija> ordinacije = [];
  List<int> odabraneOrdinacije = [];

  List<int> idGradova = [];
  List<String> naziviGradova = [];
  List<Grad> gradovi = [];
  int odabraniGrad = 1;
  List<int> uloga = [1];

  late int korisnikId;
  late Korisnik korisnik;
  List<int> slikeIds = [];

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
    fetchSpecijalizacijeDef(context);
    fetchOrdinacijeDef(context);
    fetchSpecijalizacije(context);
    fetchOrdinacije(context);
    fetchGradovi(context);
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    setState(() {
      korisnik = fetchedUser;
      imeController.text = korisnik.ime ?? '';
      prezimeController.text = korisnik.prezime ?? '';
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      korisnickoImeController.text = korisnik.korisnickoIme ?? '';
      status = korisnik.status ?? true;
    });
    return korisnik;
  }

  Future<List<Specijalizacija>> fetchSpecijalizacije(
      BuildContext context) async {
    var provider = Provider.of<SpecijalizacijaProvider>(context, listen: false);
    var fetchedspecijalizacije = await provider.get();
    naziviSpecijalizacija = fetchedspecijalizacije.result
        .map((specijalizacija) => specijalizacija.naziv ?? '')
        .toList();

    idSpecijalizacija = fetchedspecijalizacije.result
        .map((specijalizacija) => specijalizacija.specijalizacijaId ?? 0)
        .toList();
    setState(() {
      specijalizacije = fetchedspecijalizacije.result;
    });
    return specijalizacije;
  }

  Future<List<Ordinacija>> fetchOrdinacijeDef(BuildContext context) async {
    var provider =
        Provider.of<DoktorOrdinacijaProvider>(context, listen: false);
    var fetchedOrdinacije = await provider.getByDoktorIdInfo(widget.doktorId);
    naziviOrdinacijaDef = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.ordinacijaNaziv)
        .toList();

    idOrdinacijaDef = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.ordinacijaId)
        .toList();
    setState(() {
      ordinacijeDef = fetchedOrdinacije.result;
    });
    return ordinacije;
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

  Future<List<DoktorSpecijalizacija>> fetchSpecijalizacijeDef(
      BuildContext context) async {
    var provider =
        Provider.of<DoktorSpecijalizacijaProvider>(context, listen: false);
    var fetchedspecijalizacije = await provider.getByDoktorId(widget.doktorId);
    naziviSpecijalizacijaDef = fetchedspecijalizacije.result
        .map((specijalizacija) => specijalizacija.specijalizacijaNaziv ?? '')
        .toList();

    idSpecijalizacijaDef = fetchedspecijalizacije.result
        .map((specijalizacija) => specijalizacija.specijalizacijaId ?? 0)
        .toList();
    setState(() {
      specijalizacijeDef = fetchedspecijalizacije.result;
    });
    return specijalizacijeDef;
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

  Future<List<int>> fetchSlikeIds(BuildContext context) async {
    var slikeProvider = Provider.of<SlikaProvider>(context, listen: false);
    var fetchedSlike = await slikeProvider.getDoktorSlika(widget.doktorId);
    return fetchedSlike;
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        DoktorSlikaInsert insert =
            DoktorSlikaInsert(widget.doktorId, imageFile.path);
        var slikaProvider = Provider.of<SlikaProvider>(context, listen: false);

        await slikaProvider.insertSlikaDoktor(insert);
      } catch (e) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EditDoctorScreen(
              korisnikId: widget.korisnikId,
              doktorId: widget.doktorId,
            ),
          ),
        );
      }
    }
  }

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController korisnickoImeController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  bool status = true;

  List<String> selectedValuesOrdinacije = [];
  List<String> selectedValuesSpecijalizacije = [];
  String? selectedValueGrad;
  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uredi doktora'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<int>>(
        future: fetchSlikeIds(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Greška pri dohvatu podataka'));
          } else {
            List<int> slikeIds = snapshot.data!;

            return ListView(children: [
              Container(
                height: 150,
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                  child: CircleAvatar(
                    radius: 65.0,
                    backgroundColor: Colors.white,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          backgroundImage: slikeIds.isNotEmpty
                              ? NetworkImage(
                                  "https://localhost:7265/SlikaStream?slikaId=${slikeIds[0]}")
                              : AssetImage('assets/images/doctor_avatar.jpg')
                                  as ImageProvider<Object>,
                        ),
                        GestureDetector(
                          onTap: () {
                            _uploadImage();
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            child: Icon(
                              Icons.camera_alt,
                              size: 15.0,
                              color: Color(0xFF404040),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Lični podaci korisnika',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildFormField('Ime', imeController),
                              const SizedBox(height: 16.0),
                              _buildFormField('Prezime', prezimeController),
                              const SizedBox(height: 16.0),
                              _buildFormField('Email', emailController),
                              const SizedBox(height: 16.0),
                              _buildFormField('Telefon', telefonController),
                              const SizedBox(height: 16.0),
                              _buildFormField(
                                  'Korisničko ime', korisnickoImeController),
                              const SizedBox(height: 32.0),
                              _buildStatusField(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMultiselectSpecijalizacije(
                                  'Specijalizacije', context),
                              const SizedBox(height: 32.0),
                              _buildMultiselectOrdinacije(
                                  'Ordinacije', context),
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
              )
            ]);
          }
        },
      ),
    );
  }

  Widget _buildMultiselectSpecijalizacije(String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: DropDownMultiSelect(
            onChanged: (List<String> values) {
              selectedValuesSpecijalizacije = values;
              odabraneSpecijalizacije = values
                  .map((value) =>
                      idSpecijalizacija[naziviSpecijalizacija.indexOf(value)])
                  .toList();
            },
            options: naziviSpecijalizacija,
            selectedValues: naziviSpecijalizacijaDef,
            whenEmpty: 'Odaberite specijalizacije',
          ),
        ),
      ],
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
              selectedValuesOrdinacije = values;

              odabraneOrdinacije = values
                  .map((value) => idOrdinacija[naziviOrdinacija.indexOf(value)])
                  .toList();
            },
            options: naziviOrdinacija,
            selectedValues: naziviOrdinacijaDef,
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
                hint: Text("Odaberite grad"),
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
    print(odabraneSpecijalizacije);

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
                    "Da li ste sigurni da želite ažurirati korisnika sa unesenim informacijama?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Otkaži"),
                  ),
                  TextButton(
                    onPressed: () async {
                      DoktorUpdateModel updatedKorisnik = DoktorUpdateModel(
                          imeController.text,
                          prezimeController.text,
                          emailController.text,
                          telefonController.text,
                          korisnickoImeController.text,
                          status,
                          odabraniGrad,
                          odabraneSpecijalizacije,
                          uloga,
                          odabraneOrdinacije);

                      try {
                        await _korisniciProvider.updateDoktor(
                            korisnikId, updatedKorisnik);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      } catch (e) {
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
