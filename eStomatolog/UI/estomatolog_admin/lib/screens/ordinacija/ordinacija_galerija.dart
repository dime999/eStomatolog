import 'dart:io';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Slika/slika_insert.dart';
import 'package:estomatolog_admin/providers/slika_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/ordinacija_provider.dart';

class OrdinacijaGalerijaScreen extends StatefulWidget {
  final int ordinacijaId;
  const OrdinacijaGalerijaScreen({super.key, required this.ordinacijaId});

  @override
  _OrdinacijaGalerijaScreenState createState() =>
      _OrdinacijaGalerijaScreenState();
}

class _OrdinacijaGalerijaScreenState extends State<OrdinacijaGalerijaScreen> {
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrdinacijaGalerijaScreen(
              ordinacijaId: ordinacija.ordinacijaId,
            ),
          ),
        );
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

  late OrdinacijaProvider _ordinacijaProvider;
  late SlikaProvider _slikaProvider;

  @override
  Widget build(BuildContext context) {
    _slikaProvider = Provider.of<SlikaProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ordinacija info"),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Osnovne informacije o ordinaciji:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2.0),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: [
                                  FutureBuilder<List<int>>(
                                    future: fetchOrdinacijaSlike(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Text(
                                            'Greška prilikom dohvata ID-ova slika.');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    await _uploadImage();
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdinacijaGalerijaScreen(
                                                        ordinacijaId: ordinacija
                                                            .ordinacijaId,
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 32.0,
                                                    vertical: 16.0,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Dodaj novu sliku',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        List<int> slikeIds = snapshot.data!;

                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
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
                                                        currentIndex--;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Prethodna slika'),
                                                ),
                                                const SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (currentIndex <
                                                        slikeIds.length - 1) {
                                                      setState(() {
                                                        currentIndex++;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Sljedeća slika'),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    await _uploadImage();
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdinacijaGalerijaScreen(
                                                        ordinacijaId: ordinacija
                                                            .ordinacijaId,
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 32.0,
                                                    vertical: 16.0,
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Dodaj novu sliku',
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Potvrda"),
                                                        content: const Text(
                                                            "Da li ste sigurni da želite izbrisati sliku?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await _slikaProvider
                                                                    .delete(slikeIds[
                                                                        currentIndex]);

                                                                // ignore: use_build_context_synchronously
                                                                Navigator.pop(
                                                                    context);
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          "Potvrda"),
                                                                      content:
                                                                          const Text(
                                                                              "Uspješno ste izbrisali sliku!"),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            try {
                                                                              // ignore: use_build_context_synchronously

                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            } on Exception catch (e) {
                                                                              print(e);
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text("OK"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              } on Exception catch (e) {
                                                                print(e);
                                                              }
                                                            },
                                                            child: const Text(
                                                                "Da"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                "Ne"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 32.0,
                                                      vertical: 16.0,
                                                    ),
                                                    backgroundColor:
                                                        Colors.red),
                                                child: const Text(
                                                  'Izbriši sliku',
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
                          )
                        ],
                      )
                    ]))));
  }
}
