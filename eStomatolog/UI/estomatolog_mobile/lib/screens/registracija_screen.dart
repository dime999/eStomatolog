import 'package:estomatolog_mobile/models/Grad/grad.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Korisnik/pacijent_insert.dart';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
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

    if (pickedDate != null && pickedDate != DateTime.now()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija pacijenta'),
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
                        _buildDateField(),
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
        },
        child: const Text('Spremi'),
      ),
    );
  }
}
