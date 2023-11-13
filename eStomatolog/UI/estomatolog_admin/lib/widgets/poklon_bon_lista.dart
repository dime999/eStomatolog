import 'package:estomatolog_admin/models/Poklon%20bon/poklon_bon.dart';
import 'package:estomatolog_admin/providers/poklon_bon_provider.dart';
import 'package:flutter/material.dart';

class GenericListBonoviScreen extends StatefulWidget {
  final Future<List<PoklonBon>> Function(BuildContext) fetchData;
  final TextEditingController searchController;
  final PoklonBonProvider provider;

  const GenericListBonoviScreen({
    Key? key,
    required this.fetchData,
    required this.searchController,
    required this.provider,
  }) : super(key: key);

  @override
  _GenericListBonoviScreenState createState() =>
      _GenericListBonoviScreenState();
}

class _GenericListBonoviScreenState extends State<GenericListBonoviScreen> {
  late String selectedImagePath;

  @override
  void initState() {
    super.initState();
    selectedImagePath = 'assets/images/bon1.png'; // Postavite početnu sliku
  }

  void selectImage(String imagePath) {
    setState(() {
      selectedImagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.searchController,
            decoration: const InputDecoration(
              hintText: 'Pretraži po imenu korisnika...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<PoklonBon>>(
            future: widget.fetchData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(
                  child: Text('Greška pri dohvatanju podataka'),
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
                                width: 0.15 * MediaQuery.of(context).size.width,
                                height:
                                    0.15 * MediaQuery.of(context).size.height,
                                child: Image.asset(
                                  selectedImagePath,
                                  height:
                                      MediaQuery.of(context).size.width * 0.15,
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Pokon za osobu:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Status iskorištenosti:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Kupac:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Ordinacija:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Vrijednost:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: bon.iznosPlacanja.toString(),
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
                                        children: [
                                          TextSpan(
                                            text: 'Kod za aktivaciju:  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text: bon.kod == 'GENERISATI'
                                                ? 'Kod će se generisati nakon uplate'
                                                : bon.kod,
                                            style: TextStyle(
                                              color: bon.kod == 'GENERISATI'
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
                                        children: [
                                          TextSpan(
                                            text: 'Status plaćanja  ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
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
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implementirajte logiku za aktivaciju
                                      },
                                      child: Text('Aktivacija'),
                                    ),
                                    SizedBox(height: 8.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Implementirajte logiku za brisanje
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .red, // Boja kante za brisanje
                                      ),
                                      child: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              if (bon.kod != 'GENERISATI')
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        try {
                                          widget.provider
                                              .delete(bon.poklonBonId);
                                          setState(() {
                                            widget.fetchData(context);
                                          });
                                        } on Exception {
                                          String errorMessage =
                                              "Nije moguće izbrisati odabrani poklon bon!";

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Greška"),
                                                content: Text(errorMessage),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .red, // Boja kante za brisanje
                                      ),
                                      child: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
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
          ),
        ),
      ],
    );
  }
}
