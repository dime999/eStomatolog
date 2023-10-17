import 'dart:io';
import 'dart:typed_data';

import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Slika/ordinacija_slika.dart';
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
  int currentIndex = 0;
  late Ordinacija ordinacija;

  @override
  void initState() {
    super.initState();
    fetchOrdinacija(context);
  }

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    ordinacija = await ordinacijaProvider.getById(widget.ordinacijaId);
    setState(() {
      nazivController.text = ordinacija.naziv;
      telefonController.text = ordinacija.telefon ?? '';
      adresaController.text = ordinacija.adresa ?? '';
    });
    print(nazivController.text);
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
      }
    }
  }

  Future<List<int>> fetchOrdinacijaSlike(BuildContext context) async {
    var ordinacijaSlikeProvider =
        Provider.of<SlikaProvider>(context, listen: false);
    var fetchedOrdinacije =
        await ordinacijaSlikeProvider.getSlikeIds(widget.ordinacijaId);
    return fetchedOrdinacije;
  }

  TextEditingController nazivController = TextEditingController();
  TextEditingController adresaController = TextEditingController();
  TextEditingController telefonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ordinacija info")),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lični podaci pacijenta',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue, width: 2.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildFormField('Naziv', nazivController),
                                    SizedBox(height: 16.0),
                                    _buildFormField('Adresa', adresaController),
                                    SizedBox(height: 16.0),
                                    _buildFormField(
                                        'Telefon', telefonController),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Desna strana - Slike i gumb za dodavanje nove slike
                          Expanded(
                            child: Column(
                              children: [
                                FutureBuilder<List<int>>(
                                  future: fetchOrdinacijaSlike(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text(
                                          'Greška prilikom dohvata ID-ova slika.');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Text(
                                          'Nema dostupnih ID-ova slika.');
                                    } else {
                                      List<int> slikeIds = snapshot.data!;
                                      int currentIndex = 0;

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Image.network(
                                              "https://localhost:7265/SlikaStream?slikaId=${slikeIds[currentIndex]}",
                                              width: 400,
                                              height: 400,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex > 0) {
                                                    setState(() {
                                                      currentIndex--; // Prikazi prethodnu sliku
                                                    });
                                                  }
                                                },
                                                child: Text('Prethodna slika'),
                                              ),
                                              SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex <
                                                      slikeIds.length - 1) {
                                                    setState(() {
                                                      currentIndex++; // Prikazi sljedeću sliku
                                                    });
                                                  }
                                                },
                                                child: Text('Sljedeća slika'),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await _uploadImage();
                                                // Možete otvoriti dijalog za odabir slike iz galerije ili koristiti kameru
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 32.0,
                                                  vertical: 16.0,
                                                ),
                                              ),
                                              child: Text(
                                                'Dodaj novu sliku',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]))));
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: InputDecoration(border: OutlineInputBorder()),
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
