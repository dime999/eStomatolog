import 'package:estomatolog_mobile/providers/login_provider.dart';
import 'package:estomatolog_mobile/screens/home_screen.dart';
import 'package:estomatolog_mobile/screens/registracija_screen.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _korisnickoImeController =
      TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  late LoginProvider _loginProvider;

  @override
  Widget build(BuildContext context) {
    _loginProvider = context.read<LoginProvider>();
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: 110,
                  image: AssetImage('assets/images/logo.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Dobrodošli nazad',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Prijavite se kako biste pristupili svojem računu',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _korisnickoImeController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        FontAwesomeIcons.envelopeCircleCheck,
                        color: Colors.black,
                        size: 20,
                      ),
                      labelText: 'Korisničko ime',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10.0),
                      labelStyle: const TextStyle(fontSize: 14.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _lozinkaController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        FontAwesomeIcons.lock,
                        color: Colors.black,
                        size: 20,
                      ),
                      labelText: 'Lozinka',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10.0),
                      labelStyle: const TextStyle(fontSize: 14.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {
                          value = value;
                        },
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Zapamti me',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        var korisnickoIme = _korisnickoImeController.text;
                        var lozinka = _lozinkaController.text;
                        Authorization.korisnickoIme = korisnickoIme;
                        Authorization.lozinka = lozinka;
                        try {
                          await _loginProvider.login();
                          var id = Authorization.korisnikId;
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                korisnikId: id,
                              ),
                            ),
                            (route) => false,
                          );
                        } on Exception {
                          String errorMessage =
                              "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Greška"),
                                content: Text(errorMessage),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Prijavi se'),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegistracijaScreen(),
                          ),
                        );
                      },
                      child: const Text('Nemate račun? Registruj se!'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
