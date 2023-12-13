import 'dart:io';
import 'package:estomatolog_admin/models/Doktor/doktor_slika_insert.dart';
import 'package:estomatolog_admin/models/Korisnik/doktor_update.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/validator.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:estomatolog_admin/screens/login.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditDoctorScreen extends StatefulWidget {
  final int korisnikId;
  final int doktorId;

  const EditDoctorScreen(
      {super.key, required this.korisnikId, required this.doktorId});

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  List<int> uloga = [1];

  late int korisnikId;
  late Korisnik korisnik;
  List<int> slikeIds = [];
  bool _isImeValid = true;
  bool _isPrezimeValid = true;
  bool _isTelefonValid = true;
  bool _isEmailValid = true;
  bool _isKorisnickoImeValid = true;
  bool _isLozinkaValid = true;
  bool _isLozinkaPotvrdaValid = true;

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
  TextEditingController lozinkaController = TextEditingController();
  TextEditingController lozinkaPotvrdaController = TextEditingController();
  bool status = true;
  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Uredi doktora'),
          centerTitle: true,
        ),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lični podaci doktora',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                    bool isValid =
                                        Validators.validirajIme(value);
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
                                    bool isValid =
                                        Validators.validirajEmail(value);
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
                                        Validators.validirajKorisnickoIme(
                                            value);
                                    setState(() {
                                      _isKorisnickoImeValid = isValid;
                                    });
                                  },
                                ),
                                const SizedBox(height: 32.0),
                                Text("Promjena lozinke nije obavezna"),
                                const SizedBox(height: 16.0),
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
                                        Validators.validirajLozinku(value);
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
                                        Validators.validirajLozinku(value);
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
                ))));
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Obavijest'),
          content: Text(
              'Promijenili ste lozinku. Molimo vas da se ponovo prijavite.'),
          actions: [
            TextButton(
              onPressed: () {
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
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    return SizedBox(
      width: 200.0,
      child: ElevatedButton(
        onPressed: _isImeValid &&
                _isPrezimeValid &&
                _isEmailValid &&
                _isKorisnickoImeValid &&
                _isTelefonValid &&
                _isLozinkaValid &&
                _isLozinkaPotvrdaValid
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
                            DoktorUpdateModel updatedKorisnik =
                                DoktorUpdateModel(
                                    imeController.text,
                                    prezimeController.text,
                                    emailController.text,
                                    telefonController.text,
                                    korisnickoImeController.text,
                                    status,
                                    1,
                                    [],
                                    uloga,
                                    [],
                                    lozinkaController.text,
                                    lozinkaPotvrdaController.text);

                            try {
                              await _korisniciProvider.updateDoktor(
                                  korisnikId, updatedKorisnik);
                              if (lozinkaController.text != "" &&
                                  Authorization.korisnikId != korisnikId) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else {
                                showLogoutDialog(context);
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
              }
            : null,
        child: const Text('Spremi'),
      ),
    );
  }
}
