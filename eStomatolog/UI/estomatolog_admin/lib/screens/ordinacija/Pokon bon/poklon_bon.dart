import 'dart:math';

import 'package:estomatolog_admin/models/Poklon%20bon/poklon_bon.dart';
import 'package:estomatolog_admin/models/Poklon%20bon/poklon_bon_update.dart';
import 'package:estomatolog_admin/models/search_result.dart';
import 'package:estomatolog_admin/providers/poklon_bon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoklonBonScreen extends StatefulWidget {
  final int ordinacijaId;

  const PoklonBonScreen({super.key, required this.ordinacijaId});
  @override
  _PoklonBonScreenScreenState createState() => _PoklonBonScreenScreenState();
}

class _PoklonBonScreenScreenState extends State<PoklonBonScreen> {
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  Future<List<PoklonBon>> fetchPoklonBonovi(
      BuildContext context, String searchQuery) async {
    var poklonBonProvider =
        Provider.of<PoklonBonProvider>(context, listen: false);
    var fetchedBonovi = await poklonBonProvider.get(widget.ordinacijaId);

    var filteredBonovi = fetchedBonovi.result.where((bon) {
      var ime = bon.imePrezimeKorisnikaKojiKoristi.toLowerCase();
      var kod = bon.kod!.toLowerCase();

      return ime.contains(searchQuery.toLowerCase()) ||
          kod.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredBonovi;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();
  PoklonBonProvider _poklonBonProvider = PoklonBonProvider();

  @override
  Widget build(BuildContext context) {
    _poklonBonProvider = Provider.of<PoklonBonProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Poklon Bonovi'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText:
                      'Pretraži po imenu korisnika ili aktivacionom kodu!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<String>(
                  valueListenable: searchQueryNotifier,
                  builder: (context, searchQuery, child) {
                    return FutureBuilder<List<PoklonBon>>(
                      future:
                          fetchPoklonBonovi(context, searchQueryNotifier.value),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(
                            child: Text('Greška pri dohvatanju podataka'),
                          );
                        } else if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('Trenutno nema poklon bonova!'),
                          );
                        } else {
                          var bonovi = snapshot.data!;

                          return ListView.builder(
                            itemCount: bonovi.length,
                            itemBuilder: (context, index) {
                              var bon = bonovi[index];

                              return Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 0.15 *
                                              MediaQuery.of(context).size.width,
                                          height: 0.15 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .height,
                                          child: bon.iznosPlacanja == 30
                                              ? Image.asset(
                                                  'assets/images/bon1.png',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                )
                                              : bon.iznosPlacanja == 50
                                                  ? Image.asset(
                                                      'assets/images/bon2.png',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                    )
                                                  : bon.iznosPlacanja == 100
                                                      ? Image.asset(
                                                          'assets/images/bon3.png',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                        )
                                                      : null,
                                        ),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Pokon za osobu:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon
                                                          .imePrezimeKorisnikaKojiKoristi,
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          'Status iskorištenosti:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.iskoristeno
                                                          ? 'ISKORIŠTENO'
                                                          : 'Nije iskorišteno',
                                                      style: TextStyle(
                                                        color: bon.iskoristeno
                                                            ? Colors.red
                                                            : Colors.green,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Kupac:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.pacijentIme +
                                                          " " +
                                                          bon.pacijentPrezime,
                                                      style: TextStyle(
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'Ordinacija:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.ordinacijaNaziv,
                                                      style: TextStyle(
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Vrijednost:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 202, 213, 222),
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.iznosPlacanja
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text:
                                                          'Kod za aktivaciju:  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.kod ==
                                                              'GENERISATI'
                                                          ? 'Kod će se generisati nakon uplate'
                                                          : bon.kod,
                                                      style: TextStyle(
                                                        color: bon.kod ==
                                                                'GENERISATI'
                                                            ? Colors.red
                                                            : Colors.green,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 8.0),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: 'Status plaćanja  ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue,
                                                        fontSize: 13.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: bon.placeno
                                                          ? 'Plaćeno'
                                                          : 'NIJE PLAĆENO',
                                                      style: TextStyle(
                                                        color: bon.placeno
                                                            ? Colors.green
                                                            : Colors.red,
                                                        fontSize: 13.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (bon.kod == 'GENERISATI')
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  Random random = Random();
                                                  int min = 100000;
                                                  int max = 999999;
                                                  int randomNumber = min +
                                                      random.nextInt(max - min);
                                                  String kodUpdate =
                                                      randomNumber.toString();

                                                  try {
                                                    PoklonBonUpdate bonUpdate =
                                                        new PoklonBonUpdate(
                                                            bon.pacijentId,
                                                            bon.ordinacijaId,
                                                            kodUpdate,
                                                            bon.iznosPlacanja,
                                                            bon.imePrezimeKorisnikaKojiKoristi,
                                                            true,
                                                            bon.datumIstekaKartice,
                                                            bon.brojKartice,
                                                            bon.cvcCvvKod,
                                                            false);

                                                    await _poklonBonProvider
                                                        .update(bon.poklonBonId,
                                                            bonUpdate);
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Potvrda plaćanja"),
                                                          content: Text(
                                                              "Poklon bon je označen kao plaćen i kod za aktivaciju je :${kodUpdate}!"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    Navigator.of(context).pop();
                                                  } catch (e) {}
                                                },
                                                child: Text('Plaćeno'),
                                              ),
                                              SizedBox(width: 12.0),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    bool deleteConfirmed =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Potvrda brisanja"),
                                                          content: const Text(
                                                              "Da li ste sigurni da želite izbrisati odabrani poklon bon?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text("Da"),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                              child: Text("Ne"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                    if (deleteConfirmed) {
                                                      _poklonBonProvider.delete(
                                                          bon.poklonBonId);
                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Poklon bon je uspješno izbrisan.'),
                                                          duration: Duration(
                                                              seconds: 4),
                                                        ),
                                                      );
                                                      setState(() {
                                                        fetchPoklonBonovi(
                                                            context,
                                                            searchQuery);
                                                      });
                                                      Navigator.pop(context);
                                                    }
                                                  } catch (exception) {
                                                    print("Greska");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                                child: Text("Izbriši"),
                                              ),
                                            ],
                                          ),
                                        if (bon.kod != 'GENERISATI' &&
                                            bon.iskoristeno == false)
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    PoklonBonUpdate bonUpdate =
                                                        new PoklonBonUpdate(
                                                            bon.pacijentId,
                                                            bon.ordinacijaId,
                                                            bon.kod,
                                                            bon.iznosPlacanja,
                                                            bon.imePrezimeKorisnikaKojiKoristi,
                                                            true,
                                                            bon.datumIstekaKartice,
                                                            bon.brojKartice,
                                                            bon.cvcCvvKod,
                                                            true);

                                                    await _poklonBonProvider
                                                        .update(bon.poklonBonId,
                                                            bonUpdate);
                                                    await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Potvrda plaćanja"),
                                                          content: Text(
                                                              "Poklon bon je označen kao AKTIVIRAN i ne može se više koristiti!"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    Navigator.of(context).pop();
                                                  } catch (e) {}
                                                },
                                                child: Text('Aktiviraj'),
                                              ),
                                              SizedBox(width: 12.0),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    bool deleteConfirmed =
                                                        await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Potvrda brisanja"),
                                                          content: const Text(
                                                              "Da li ste sigurni da želite izbrisati odabrani poklon bon?"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text("Da"),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                              child: Text("Ne"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                    if (deleteConfirmed) {
                                                      _poklonBonProvider.delete(
                                                          bon.poklonBonId);
                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Poklon bon je uspješno izbrisan.'),
                                                          duration: Duration(
                                                              seconds: 4),
                                                        ),
                                                      );
                                                      setState(() {
                                                        fetchPoklonBonovi(
                                                            context,
                                                            searchQuery);
                                                      });
                                                      Navigator.pop(context);
                                                    }
                                                  } catch (exception) {
                                                    print("Greska");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                ),
                                                child: Text("Izbriši"),
                                              ),
                                            ],
                                          ),
                                        if (bon.kod != 'GENERISATI' &&
                                            bon.iskoristeno == true)
                                          Row(children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  bool deleteConfirmed =
                                                      await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Potvrda brisanja"),
                                                        content: const Text(
                                                            "Da li ste sigurni da želite izbrisati odabrani poklon bon?"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(true);
                                                            },
                                                            child: Text("Da"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(false);
                                                            },
                                                            child: Text("Ne"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                  if (deleteConfirmed) {
                                                    _poklonBonProvider.delete(
                                                        bon.poklonBonId);
                                                    // ignore: use_build_context_synchronously
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Poklon bon je uspješno izbrisan.'),
                                                        duration: Duration(
                                                            seconds: 4),
                                                      ),
                                                    );
                                                    setState(() {
                                                      fetchPoklonBonovi(
                                                          context, searchQuery);
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                } catch (exception) {
                                                  print("Greska");
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                              ),
                                              child: Text("Izbriši"),
                                            ),
                                          ])
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1.0,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  }),
            )
          ],
        ));
  }
}
