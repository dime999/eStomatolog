import 'package:estomatolog_admin/models/Grad/grad.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Specijalizacija/specijalizacija.dart';
import 'package:estomatolog_admin/providers/grad_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/specijalizacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  List<int> idSpecijalizacija = [];
  List<String> naziviSpecijalizacija = [];
  List<Specijalizacija> specijalizacije = [];
  List<int> odabraneSpecijalizacije = [];

  List<int> idOrdinacija = [];
  List<String> naziviOrdinacija = [];
  List<Ordinacija> ordinacije = [];
  List<int> odabraneOrdinacije = [];

  List<int> idGradova = [];
  List<String> naziviGradova = [];
  List<Grad> gradovi = [];
  int odabraniGrad = 1;
  List<int> uloga = [1];
  late Korisnik korisnik;

  @override
  void initState() {
    super.initState();
    fetchSpecijalizacije(context);
    fetchOrdinacije(context);
    fetchGradovi(context);
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

  Future<List<Ordinacija>> fetchOrdinacije(BuildContext context) async {
    var provider = Provider.of<OrdinacijaProvider>(context, listen: false);
    var fetchedOrdinacije = await provider.get();
    naziviOrdinacija = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.naziv ?? '')
        .toList();

    idOrdinacija = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.ordinacijaId ?? 0)
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
  List<String> selectedValuesSpecijalizacije = [];
  String? selectedValueGrad;
  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj novog doktora'),
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
                        const SizedBox(height: 16.0),
                        _buildPasswordField('Lozinka', lozinkaController),
                        const SizedBox(height: 16.0),
                        _buildPasswordField(
                            'Lozinka potvrda', lozinkaPotvrdaController),
                        const SizedBox(height: 32.0),
                        _buildStatusField(),
                      ],
                    ),
                  ),
                  const SizedBox(
                      width: 32.0), // Razmak između lijevog i desnog stupca
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMultiselectSpecijalizacije(
                            'Specijalizacije', context),
                        const SizedBox(height: 32.0),
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
              setState(() {
                selectedValuesSpecijalizacije = values;
                odabraneSpecijalizacije = values
                    .map((value) =>
                        idSpecijalizacija[naziviSpecijalizacija.indexOf(value)])
                    .toList();
              });
            },
            options: naziviSpecijalizacija,
            selectedValues: selectedValuesSpecijalizacije,
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
        border:
            Border.all(color: const Color.fromARGB(255, 146, 140, 140), width: 1.0),
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
            obscureText: true, // Postavite na true da biste sakrili tekst
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
    Korisnik korisnik = Korisnik(
        imeController.text,
        prezimeController.text,
        emailController.text,
        telefonController.text,
        korisnickoImeController.text,
        status,
        odabraniGrad,
        odabraneSpecijalizacije,
        uloga,
        odabraneOrdinacije,
        lozinkaController.text,
        lozinkaPotvrdaController.text);
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
                    "Da li ste sigurni da želite dodati korisnika sa unesenim informacijama?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Zatvaranje dijaloga
                    },
                    child: const Text("Otkaži"),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await _korisniciProvider.insert(korisnik);
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
