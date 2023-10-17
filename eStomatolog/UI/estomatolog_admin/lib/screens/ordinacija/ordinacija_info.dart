import 'dart:io';

import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Slika/slika_insert.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/ordinacija_provider.dart';

class OrdinacijaDetaljiScreen extends StatefulWidget {
  final int ordinacijaId;
  OrdinacijaDetaljiScreen({required this.ordinacijaId});

  @override
  _OrdinacijaDetaljiScreenState createState() =>
      _OrdinacijaDetaljiScreenState();
}

class _OrdinacijaDetaljiScreenState extends State<OrdinacijaDetaljiScreen> {
  late Future<Ordinacija> _ordinacijaFuture;

  @override
  void initState() {
    super.initState();
    _ordinacijaFuture = fetchOrdinacija(widget.ordinacijaId);
  }

  Future<Ordinacija> fetchOrdinacija(int ordinacijaId) async {
    var pacijentProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var ordinacija = await pacijentProvider.getById(ordinacijaId);
    return ordinacija;
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        SlikaInsert insert = SlikaInsert(widget.ordinacijaId, imageFile.path);
        var slikaProvider = Provider.of<SlikaProvider>(context, listen: false);

        await slikaProvider.insertSlikaOrdinacija(insert);
      } catch (e) {
        print("Error uploading image: $e");
        // Rukovanje greškom prilikom slanja slike
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ordinacija info")),
      body: Center(
        child: FutureBuilder<Ordinacija>(
          future: _ordinacijaFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Greška pri dohvatu podataka o ordinaciji.');
            } else if (!snapshot.hasData) {
              return Text('Nema dostupnih podataka o ordinaciji.');
            } else {
              Ordinacija ordinacija = snapshot.data!;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ordinacija.naziv,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              ordinacija.adresa,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              ordinacija.telefon,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              ordinacija.gradId.toString(),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 200.0,
                      child: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: List.generate(
                          6, // Zamijenite ovo s brojem stvarnih slika
                          (index) {
                            // Ovdje trebate dohvatiti i prikazati stvarne slike
                            return Container(
                              width: 200.0,
                              height: 200.0,
                              color: Colors.grey,
                              child: Center(
                                child: Text(
                                  'Slika ${index + 1}',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      // Vaša postojeća sadržaj i druge komponente
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await _uploadImage();
                              // Možete otvoriti dijalog za odabir slike iz galerije ili koristiti kameru
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical:
                                      16.0), // Prilagodite veličinu gumba ovdje
                            ),
                            child: Text(
                              'Dodaj novu sliku',
                              style: TextStyle(
                                  fontSize:
                                      18.0), // Prilagodite veličinu teksta ovdje
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
