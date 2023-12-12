import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Korisnik/pacijent_update.dart';
import 'package:estomatolog_admin/models/validator.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPacijentScreen extends StatefulWidget {
  final int korisnikId;
  final int pacijentId;

  const EditPacijentScreen(
      {super.key, required this.korisnikId, required this.pacijentId});

  @override
  _EditPacijentScreenState createState() => _EditPacijentScreenState();
}

class _EditPacijentScreenState extends State<EditPacijentScreen> {
  List<int> uloga = [2];
  List<int> odabraneOrdinacije = [];
  int odabraniGrad = 1;

  late int korisnikId;
  late Korisnik korisnik;
  bool _isImeValid = true;
  bool _isPrezimeValid = true;
  bool _isTelefonValid = true;
  bool _isEmailValid = true;
  bool _isKorisnickoImeValid = true;

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
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

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController korisnickoImeController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  bool status = true;

  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Uredi pacijenta'),
          centerTitle: true,
        ),
        body: Center(
            child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lični podaci pacijenta',
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
                                bool isValid =
                                    Validators.validirajPrezime(value);
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
                            const SizedBox(height: 32.0),
                            _buildStatusField(),
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
        )));
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
    return SizedBox(
      width: 200.0,
      child: ElevatedButton(
        onPressed: _isImeValid &&
                _isPrezimeValid &&
                _isEmailValid &&
                _isKorisnickoImeValid &&
                _isTelefonValid
            ? () async {
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
                              PacijentUpdateModel updatedKorisnik =
                                  PacijentUpdateModel(
                                      korisnikId,
                                      imeController.text,
                                      prezimeController.text,
                                      emailController.text,
                                      telefonController.text,
                                      korisnickoImeController.text,
                                      status,
                                      odabraniGrad,
                                      uloga,
                                      odabraneOrdinacije,
                                      '',
                                      '');
                              await _korisniciProvider.updatePacijent(
                                  korisnikId, updatedKorisnik);
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
              }
            : null,
        child: const Text('Spremi'),
      ),
    );
  }
}
