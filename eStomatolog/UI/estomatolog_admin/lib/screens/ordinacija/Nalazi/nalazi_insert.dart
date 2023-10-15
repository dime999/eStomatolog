import 'package:flutter/material.dart';

class DodajNalazScreen extends StatefulWidget {
  final int pacijentId;

  DodajNalazScreen({required this.pacijentId});

  @override
  _DodajNalazScreenState createState() => _DodajNalazScreenState();
}

class _DodajNalazScreenState extends State<DodajNalazScreen> {
  TextEditingController opisController = TextEditingController();

  void _snimiNalaz() async {
    String opis = opisController.text;
    DateTime datum = DateTime.now();

    // Ovdje pozovite vaš API endpoint za spremanje nalaza
    // Primjer poziva API-ja sa http paketom:
    // await http.post('https://api.example.com/nalazi', body: {'opis': opis, 'datum': datum.toString(), 'pacijentId': widget.pacijentId.toString()});

    // Nakon spremanja nalaza možete izvršiti odgovarajuće akcije, npr. prikazati poruku o uspješnom spremanju.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodaj novi nalaz'),
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
              onPressed: _snimiNalaz,
              child: Text('Snimi nalaz'),
            ),
          ],
        ),
      ),
    );
  }
}
