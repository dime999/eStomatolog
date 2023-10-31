import 'package:estomatolog_mobile/models/Doktor/doktor.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor_specijalizacija.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/doktor_specijalizacije_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoktorInfoScreen extends StatefulWidget {
  final int korisnikId;

  const DoktorInfoScreen({super.key, required this.korisnikId});

  @override
  _DoktorInfoScreenState createState() => _DoktorInfoScreenState();
}

class _DoktorInfoScreenState extends State<DoktorInfoScreen> {
  late int korisnikId;
  late Korisnik korisnik;
  late Doktor doktor;
  List<DoktorSpecijalizacija> specijalizacijeDoktora = [];
  List<String> naziviSpecijalizacija = [];

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var fetchedDoktor = await doktorProvider.getByKorisnikId(widget.korisnikId);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    setState(() {
      korisnik = fetchedUser;
      doktor = fetchedDoktor;
      imeController.text = korisnik.ime ?? '';
      prezimeController.text = korisnik.prezime ?? '';
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      status = korisnik.status ?? true;
    });
    await fetchDoktorSpecijalizacije(context);
    return korisnik;
  }

  Future<List<DoktorSpecijalizacija>> fetchDoktorSpecijalizacije(
      BuildContext context) async {
    var provider =
        Provider.of<DoktorSpecijalizacijaProvider>(context, listen: false);
    var fetchedSpec = await provider.getByDoktorId(doktor.id);
    naziviSpecijalizacija = fetchedSpec.result
        .map((specijalizacija) => specijalizacija.specijalizacijaNaziv ?? '')
        .toList();
    setState(() {
      specijalizacijeDoktora = fetchedSpec.result;
    });
    print(naziviSpecijalizacija);
    return specijalizacijeDoktora;
  }

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  bool status = true;

  List<String> selectedValuesSpecijalizacije = [];
  String? selectedValueGrad;

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
                        const SizedBox(height: 32.0),
                        Text(
                          'Specijalizacije:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: List.generate(
                              naziviSpecijalizacija.length,
                              (index) {
                                Color color = Colors
                                    .primaries[index % Colors.primaries.length];

                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 4.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    naziviSpecijalizacija[index],
                                    style: TextStyle(color: color),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
            readOnly: true,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 35, 87, 220),
                fontFamily: ''),
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
