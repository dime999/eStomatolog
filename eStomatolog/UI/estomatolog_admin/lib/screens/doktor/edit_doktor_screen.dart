import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';

class EditDoctorScreen extends StatefulWidget {
  final int korisnikId;

  EditDoctorScreen({required this.korisnikId});

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  late int korisnikId;
  late Korisnik korisnik;

  @override
  void initState() {
    super.initState();
    korisnikId = widget
        .korisnikId; // Postavite korisnikId u initState koristeći widget objekt
    fetchUsers(context); // Pozovite metodu za dohvaćanje podataka
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    print(fetchedUser);
    setState(() {
      korisnik = fetchedUser;
      imeController.text = korisnik.ime ?? '';
      prezimeController.text = korisnik.prezime ?? '';
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      korisnickoImeController.text = korisnik.korisnickoIme ?? '';
    });
    return korisnik;
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
                widthFactor: 0.5, // Forme zauzimaju polovicu ekrana
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
                    SizedBox(height: 32.0), // Razmak između formi
                    _buildStatusField(),
                  ],
                ),
              ),
              SizedBox(height: 32.0), // Dodatni razmak između formi i gumba
              _buildSaveButton(),
            ],
          ),
        ),
      ),
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
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Implementirajte logiku za spremanje doktora s unesenim vrijednostima
        },
        child: Text('Spremi'),
      ),
    );
  }
}
