import 'package:estomatolog_mobile/models/Grad/grad.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Specijalizacija/specijalizacija.dart';
import 'package:estomatolog_mobile/providers/grad_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/specijalizacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

class DoktorInfoScreen extends StatefulWidget {
  final int korisnikId;

  const DoktorInfoScreen({super.key, required this.korisnikId});

  @override
  _DoktorInfoScreenState createState() => _DoktorInfoScreenState();
}

class _DoktorInfoScreenState extends State<DoktorInfoScreen> {
  List<int> idSpecijalizacija = [];
  List<String> naziviSpecijalizacija = [];
  List<Specijalizacija> specijalizacije = [];
  List<int> odabraneSpecijalizacije = [];

  List<int> idGradova = [];
  List<String> naziviGradova = [];
  List<Grad> gradovi = [];
  int odabraniGrad = 1;
  List<int> uloga = [1];

  late int korisnikId;
  late Korisnik korisnik;

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
    fetchSpecijalizacije(context);
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
  bool status = true;

  List<String> selectedValuesSpecijalizacije = [];
  String? selectedValueGrad;
  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacije o doktoru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        const SizedBox(height: 32.0),
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

  Widget _buildFormField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 35, 87, 220),
            ),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 179, 177, 177),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
