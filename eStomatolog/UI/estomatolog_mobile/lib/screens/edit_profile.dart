import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Korisnik/user_update.dart';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija_pacijent.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/validator.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserScreen extends StatefulWidget {
  final int korisnikId;

  const EditUserScreen({super.key, required this.korisnikId});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  List<int> uloga = [2];

  late int korisnikId;
  late Korisnik korisnik;
  List<OrdinacijaPacijent> ordinacije = [];
  late Pacijent pacijentData;
  DateTime odabraniDatum = DateTime.now();
  late String defKorisnickoIme;

  List<int> idOrdinacija = [];

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    _fetchOrdinacijeData();
    fetchUsers(context);
  }

  Future<void> _fetchOrdinacijeData() async {
    var filteredOrdinacije = await fetchOrdinacije(context, "");
    setState(() {
      ordinacije = filteredOrdinacije;
    });
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    setState(() {
      korisnik = fetchedUser;
      imeController.text = korisnik.ime;
      prezimeController.text = korisnik.prezime;
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      korisnickoImeController.text = korisnik.korisnickoIme ?? '';
      defKorisnickoIme = korisnik.korisnickoIme ?? '';
      status = korisnik.status ?? true;
    });
    return korisnik;
  }

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getByKorisnikId(widget.korisnikId);
    return pacijent;
  }

  Future<List<OrdinacijaPacijent>> fetchOrdinacije(
      BuildContext context, String searchQuery) async {
    var ordinacijaProvider =
        Provider.of<PacijentOrdinacijaProvider>(context, listen: false);
    var pacijent = await fetchPacijent(context);
    pacijentData = pacijent;

    var fetchedOrdinacije =
        await ordinacijaProvider.getByPacijentId(pacijent.id);
    idOrdinacija = fetchedOrdinacije.result
        .map((ordinacija) => ordinacija.ordinacijaId)
        .toList();
    var filteredOrdinacije = fetchedOrdinacije.result;
    return filteredOrdinacije;
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
  bool _isImeValid = true;
  bool _isPrezimeValid = true;
  bool _isTelefonValid = true;
  bool _isEmailValid = true;
  bool _isKorisnickoImeValid = true;
  bool _isLozinkaValid = true;
  bool _isLozinkaPotvrdaValid = true;
  String? selectedValueGrad;
  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uredi profil'),
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
                        const SizedBox(height: 42.0),
                        Text("Promjena lozinke je opcionalna"),
                        const SizedBox(height: 12.0),
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
                            bool isValid =
                                Validators.validirajLozinkuUpdate(value);
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
                                : 'Lozinka i potvrda se ne podudaraju',
                          ),
                          onChanged: (value) {
                            bool isValid =
                                Validators.validirajLozinkuUpdate(value);
                            setState(() {
                              _isLozinkaPotvrdaValid = isValid;
                              if (lozinkaController.text.isNotEmpty &&
                                  lozinkaController.text != value) {
                                _isLozinkaPotvrdaValid = false;
                              } else {
                                _isLozinkaPotvrdaValid = true;
                              }
                            });
                          },
                        ),
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Obavijest'),
          content: Text(
              'Promijenili ste lozinku ili korisničko ime. Molimo vas da se ponovo prijavite.'),
          actions: [
            TextButton(
              onPressed: () {
                print("Uslo u funkciju");
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSaveButton() {
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
                      try {
                        _korisniciProvider = Provider.of<KorisniciProvider>(
                            context,
                            listen: false);
                        UserUpdateModel updatedKorisnik = UserUpdateModel(
                            imeController.text,
                            prezimeController.text,
                            emailController.text,
                            telefonController.text,
                            korisnickoImeController.text,
                            true,
                            1,
                            idOrdinacija,
                            uloga,
                            lozinkaController.text,
                            lozinkaPotvrdaController.text);

                        await _korisniciProvider.updateUser(
                            korisnikId, updatedKorisnik);
                        print(defKorisnickoIme);
                        print(korisnickoImeController.text);

                        if (lozinkaController.text.length > 3 ||
                            defKorisnickoIme != korisnickoImeController.text) {
                          Navigator.of(context).pop();
                          showLogoutDialog(context);
                        } else {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Potvrda izmjena'),
                                content: Text('Izmjene uspješno spremljene!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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
