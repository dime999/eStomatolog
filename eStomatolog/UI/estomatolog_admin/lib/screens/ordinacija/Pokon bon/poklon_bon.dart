import 'package:estomatolog_admin/models/Poklon%20bon/poklon_bon.dart';
import 'package:estomatolog_admin/providers/poklon_bon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoklonBonScreen extends StatefulWidget {
  final int ordinacijaId;
  PoklonBonScreen({required this.ordinacijaId});
  @override
  _PoklonBonScreenScreenState createState() => _PoklonBonScreenScreenState();
}

class _PoklonBonScreenScreenState extends State<PoklonBonScreen> {
  List<PoklonBon> poklonBonovi = [];

  Future<List<PoklonBon>> fetchBonovi(BuildContext context) async {
    var bonProvider = Provider.of<PoklonBonProvider>(context, listen: false);
    var fetchBonove = await bonProvider.get(widget.ordinacijaId);
    return fetchBonove.result;
  }

  late PoklonBonProvider _poklonBonProvider;

  @override
  Widget build(BuildContext context) {
    _poklonBonProvider = Provider.of<PoklonBonProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Poklon bonovi'),
      ),
      body: Center(
        child: FutureBuilder<List<PoklonBon>>(
          future: fetchBonovi(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Greška: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nema dostupnih bonova.'));
            } else {
              return Expanded(
                child: ListView(scrollDirection: Axis.vertical, children: [
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: SizedBox(
                          width: 50,
                          child: Text('Pacijent'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 80,
                          child: Text('Ordinacija'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 80,
                          child: Text('Za osobu'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Text('Opis'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 80,
                          child: Text('Vrijednost'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 80,
                          child: Text('Plaćeno'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 80,
                          child: Text('Iskorišteno'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 50,
                          child: Text('Akcije'),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.map((bon) {
                      bool jeAktivna = !bon.iskoristeno;
                      bool jePlaceno = bon.placeno;
                      String status = jeAktivna ? 'AKTIVNO' : 'NEAKTIVNO';
                      String placeno = jePlaceno ? 'PLAĆENO' : 'NIJE PLAĆENO';
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(
                              bon.pacijentIme! + ' ' + bon.pacijentPrezime ??
                                  'N/A')),
                          DataCell(Text(bon.ordinacijaNaziv ?? 'N/A')),
                          DataCell(Text(
                              bon.imePrezimeKorisnikaKojiKoristi ?? 'N/A')),
                          DataCell(Text(bon.opis ?? 'N/A')),
                          DataCell(Text(bon.iznosPlacanja.toString())),
                          DataCell(
                            Text(
                              '$placeno' ?? 'N/A',
                              style: TextStyle(
                                  color: jeAktivna ? Colors.green : Colors.red),
                            ),
                          ),
                          DataCell(
                            Text(
                              '$status' ?? 'N/A',
                              style: TextStyle(
                                  color: jeAktivna ? Colors.green : Colors.red),
                            ),
                          ),
                          DataCell(
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Potvrda"),
                                      content: Text(
                                          "Da li ste sigurni da želite izbrisati poklon bon?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              _poklonBonProvider
                                                  .delete(bon.poklonBonId);
                                              var updatedBonovi =
                                                  await fetchBonovi(context);
                                              setState(() {
                                                poklonBonovi = updatedBonovi;
                                              });

                                              Navigator.pop(
                                                  context); // Zatvori dialog
                                            } on Exception catch (e) {
                                              String errorMessage =
                                                  "Nije moguće izbrisati odabrani poklon bon!";
                                              // Prikaži grešku ako brisanje nije uspelo
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Greška"),
                                                    content: Text(errorMessage),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text("OK"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          child: Text("Da"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Ne"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
