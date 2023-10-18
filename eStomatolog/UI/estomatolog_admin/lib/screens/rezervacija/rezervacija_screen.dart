import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/models/Rezervacija/rezervacija.dart';
import 'package:estomatolog_admin/providers/rezervacija_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijaScreen extends StatefulWidget {
  final int ordinacijaId;
  RezervacijaScreen({required this.ordinacijaId});
  @override
  _RezervacijaScreenState createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  List<Rezervacija> rezervacije = [];

  Future<List<Rezervacija>> fetchRezervacije(BuildContext context) async {
    var rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    var fetchedRezervacije = await rezervacijaProvider.get(widget.ordinacijaId);
    return fetchedRezervacije.result;
  }

  late RezervacijaProvider _rezervacijaProvider;

  @override
  Widget build(BuildContext context) {
    _rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacije'),
      ),
      body: Center(
        child: FutureBuilder<List<Rezervacija>>(
          future: fetchRezervacije(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Greška: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nema dostupnih rezervacija.'));
            } else {
              return Expanded(
                child: ListView(scrollDirection: Axis.vertical, children: [
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Text('Pacijent'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Text('Doktor'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Text('Ordinacija'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 100,
                          child: Text('Email potvrde rezervacije'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 250,
                          child: Text('Termin vrijeme i datum'),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 50,
                          child: Text('Akcije'),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.map((rezervacija) {
                      DateTime trenutnoVreme = DateTime.now();
                      String formattedDate = DateFormat('dd.MM.yyyy')
                          .format(rezervacija.terminVrijeme);
                      String formattedTime =
                          DateFormat('HH:mm').format(rezervacija.terminVrijeme);
                      bool jeAktivna =
                          rezervacija.terminVrijeme.isAfter(trenutnoVreme);
                      String status = jeAktivna ? 'AKTIVNO' : 'NEAKTIVNO';
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(rezervacija.pacijentIme! +
                                  ' ' +
                                  rezervacija.pacijentPrezime ??
                              'N/A')),
                          DataCell(Text(rezervacija.doktorIme! +
                                  ' ' +
                                  rezervacija.doktorPrezime ??
                              'N/A')),
                          DataCell(Text(rezervacija.ordinacijaNaziv ?? 'N/A')),
                          DataCell(Text(rezervacija.email ?? 'N/A')),
                          DataCell(
                            Text(
                              '$status: $formattedDate' +
                                      ' / ' +
                                      '$formattedTime' ??
                                  'N/A',
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
                                          "Da li ste sigurni da želite izbrisati rezervaciju?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              _rezervacijaProvider.delete(
                                                  rezervacija.rezervacijaId);
                                              var updatedRezervacije =
                                                  await fetchRezervacije(
                                                      context);
                                              setState(() {
                                                rezervacije =
                                                    updatedRezervacije;
                                              });

                                              Navigator.pop(
                                                  context); // Zatvori dialog
                                            } on Exception catch (e) {
                                              String errorMessage =
                                                  "Nije moguće izbrisati odabranu rezervaciju!";
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
