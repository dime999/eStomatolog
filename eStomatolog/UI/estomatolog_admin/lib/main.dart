import 'package:estomatolog_admin/screens/home.dart';
import 'package:estomatolog_admin/screens/registracija.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  TextEditingController _korisnickoImeController = new TextEditingController();
  TextEditingController _lozinkaController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  var korisnickoIme = _korisnickoImeController.text;
                  var lozinka = _lozinkaController.text;
                  print("$korisnickoIme $lozinka");

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
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
