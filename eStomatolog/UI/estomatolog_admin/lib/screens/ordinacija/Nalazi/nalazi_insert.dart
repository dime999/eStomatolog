import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DodajNalazScreen extends StatefulWidget {
  final int pacijentId;

  DodajNalazScreen({required this.pacijentId});

  @override
  _DodajNalazScreenState createState() => _DodajNalazScreenState();
}

class _DodajNalazScreenState extends State<DodajNalazScreen> {
  TextEditingController opisController = TextEditingController();
  late Pacijent pacijent;

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getByKorisnikId(widget.pacijentId);
    return pacijent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Pacijent>(
          future: fetchPacijent(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Dodaj nalaz - Učitavanje...');
            } else if (snapshot.hasError) {
              return Text('Greška pri dohvatu pacijenta.');
            } else if (!snapshot.hasData) {
              return Text('Nema dostupnih podataka o pacijentu.');
            } else {
              pacijent = snapshot.data!;
              return Text(
                  'Dodaj nalaz za: - ${pacijent.ime} ${pacijent.prezime} ');
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: opisController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Unesite opis nalaza',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Datum: ${DateTime.now().toString()}'),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                try {} catch (e) {
                  print("Greška prilikom dodavanja: $e");
                  Navigator.of(context).pop();
                }
              },
              child: Text('Snimi nalaz'),
            ),
          ],
        ),
      ),
    );
  }
}
