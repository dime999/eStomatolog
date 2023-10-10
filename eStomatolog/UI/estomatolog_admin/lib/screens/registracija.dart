import 'package:estomatolog_admin/main.dart';
import 'package:estomatolog_admin/screens/login.dart';
import 'package:estomatolog_admin/widgets/master_screeen.dart';
import 'package:flutter/material.dart';

TextStyle inputTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

InputDecoration inputDecoration(String labelText, Icon prefixIcon) {
  return InputDecoration(
    labelText: labelText,
    prefixIcon: prefixIcon,
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Colors.blue),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
    ),
  );
}

class RegistracijaScreen extends StatefulWidget {
  const RegistracijaScreen({super.key});

  @override
  State<RegistracijaScreen> createState() => _RegistracijatScreenState();
}

class _RegistracijatScreenState extends State<RegistracijaScreen> {
  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController korisnickoImeController = TextEditingController();
  TextEditingController lozinkaController = TextEditingController();
  TextEditingController lozinkaPotvrdaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registracija doktora'),
        ),
        body: Center(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Postavite željenu širinu forme

                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: imeController,
                      style: inputTextStyle,
                      decoration: inputDecoration('Ime', Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite ime';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: prezimeController,
                      style: inputTextStyle,
                      decoration:
                          inputDecoration('Prezime', Icon(Icons.person)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite prezime';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailController,
                      style: inputTextStyle,
                      decoration: inputDecoration('Email', Icon(Icons.mail)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite email adresu';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: telefonController,
                      style: inputTextStyle,
                      decoration: inputDecoration('Telefon', Icon(Icons.phone)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite telefon';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: korisnickoImeController,
                      style: inputTextStyle,
                      decoration: inputDecoration(
                          'Korisničko ime', Icon(Icons.person_2_sharp)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite korisničko ime';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: lozinkaController,
                      style: inputTextStyle,
                      decoration: inputDecoration('Lozinka', Icon(Icons.key)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo unesite lozinku';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: lozinkaPotvrdaController,
                      style: inputTextStyle,
                      decoration:
                          inputDecoration('Lozinka potvrda', Icon(Icons.key)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Molimo potvrdite lozinku';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false,
                        );
                      },
                      child: Text('Registracija'),
                    ),
                  ],
                ),
              )),
        ));
  }

  bool validateForm() {
    return Form.of(context)!.validate();
  }
}
