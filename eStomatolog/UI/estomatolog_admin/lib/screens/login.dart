import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/login_provider.dart';
import 'package:estomatolog_admin/screens/home.dart';
import 'package:estomatolog_admin/screens/registracija.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _korisnickoImeController = new TextEditingController();
  TextEditingController _lozinkaController = new TextEditingController();

  late LoginProvider _loginProvider;

  @override
  Widget build(BuildContext context) {
    _loginProvider = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Prijavi se")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'eStomatolog',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/images/logo.avif",
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Korisničko ime',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  controller: _korisnickoImeController,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    labelText: 'Lozinka',
                    border: OutlineInputBorder(),
                  ),
                  controller: _lozinkaController,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  var korisnickoIme = _korisnickoImeController.text;
                  var lozinka = _lozinkaController.text;
                  Authorization.korisnickoIme = korisnickoIme;
                  Authorization.lozinka = lozinka;
                  try {
                    await _loginProvider.login();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false,
                    );
                  } on Exception catch (e) {
                    String errorMessage =
                        "Netačno korisničko ime ili lozinka. Molimo pokušajte ponovo.";
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Greška"),
                          content: Text(errorMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text(
                    'Prijavi se',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RegistracijaScreen()));
                },
                child: Text(
                  'Nemate račun? Registruj se!',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
