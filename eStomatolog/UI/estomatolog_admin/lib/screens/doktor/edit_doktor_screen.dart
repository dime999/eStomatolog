import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Specijalizacija/specijalizacija.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/specijalizacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

class EditDoctorScreen extends StatefulWidget {
  final int korisnikId;

  EditDoctorScreen({required this.korisnikId});

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  List<int> idSpecijalizacija = [];
  List<String> naziviSpecijalizacija = [];
  List<Specijalizacija> specijalizacije = [];
  List<int> odabraneSpecijalizacije = [];
  late int korisnikId;
  late Korisnik korisnik;

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
    fetchSpecijalizacije(context);
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

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController korisnickoImeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController passwordPotvrdaController = TextEditingController();
  bool status = true;

  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uredi doktora'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lični podaci korisnika',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              FractionallySizedBox(
                alignment: Alignment.topLeft,
                widthFactor: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormField('Ime', imeController),
                    SizedBox(height: 16.0),
                    _buildFormField('Prezime', prezimeController),
                    SizedBox(height: 16.0),
                    _buildFormField('Email', emailController),
                    SizedBox(height: 16.0),
                    _buildFormField('Telefon', telefonController),
                    SizedBox(height: 16.0),
                    _buildFormField('Korisničko ime', korisnickoImeController),
                    SizedBox(height: 16.0),
                    _buildFormField('Lozinka', passwordController,
                        isObscure: true),
                    SizedBox(height: 16.0),
                    _buildFormField('Datum rođenja', datumRodjenjaController),
                    SizedBox(height: 16.0),
                    _buildFormField(
                        'Potvrda lozinke', passwordPotvrdaController,
                        isObscure: true),
                    SizedBox(height: 32.0),
                    _buildStatusField(),
                    SizedBox(height: 16.0),
                    _buildMultiselect('Specijalizacije', context),
                    SizedBox(height: 32.0),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultiselect(String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: DropDownMultiSelect(
            onChanged: (List<String> values) {
              setState(() {
                selectedValues = values;
                odabraneSpecijalizacije = values
                    .map((value) =>
                        idSpecijalizacija[naziviSpecijalizacija.indexOf(value)])
                    .toList();
              });
            },
            options: naziviSpecijalizacija,
            selectedValues: selectedValues,
            whenEmpty: 'Odaberite specijalizacije',
          ),
        ),
      ],
    );
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusField() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status'),
          SizedBox(height: 8.0),
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
    return Container(
      width: 200.0,
      child: ElevatedButton(
        onPressed: () {
          // Implementirajte logiku za spremanje doktora s unesenim vrijednostima
        },
        child: Text('Spremi'),
      ),
    );
  }
}
