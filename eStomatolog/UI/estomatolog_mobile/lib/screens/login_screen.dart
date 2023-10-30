import 'package:estomatolog_mobile/providers/login_provider.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Prijavi se")),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'eStomatolog',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    "assets/images/logo.avif",
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Korisničko ime',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      controller: _korisnickoImeController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        labelText: 'Lozinka',
                        border: OutlineInputBorder(),
                      ),
                      controller: _lozinkaController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      var korisnickoIme = _korisnickoImeController.text;
                      var lozinka = _lozinkaController.text;
                      Authorization.korisnickoIme = korisnickoIme;
                      Authorization.lozinka = lozinka;
                      try {
                        print("Ovdje");
                        await _loginProvider.login();
                        /* Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );*/
                      } on Exception {
                        String errorMessage =
                            "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Text(
                        'Prijavi se',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      //  Navigator.of(context).push(MaterialPageRoute(
                      //    builder: (context) => const RegistracijaScreen()));
                    },
                    child: const Text(
                      'Nemate račun? Registruj se!',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
