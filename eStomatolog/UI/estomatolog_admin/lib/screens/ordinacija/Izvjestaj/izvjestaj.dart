import 'package:estomatolog_admin/models/Izvjestaj/izvjestaj.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class IzvjestajScreen extends StatefulWidget {
  final int ordinacijaId;

  IzvjestajScreen({required this.ordinacijaId});

  @override
  _IzvjestajScreenState createState() => _IzvjestajScreenState();
}

class _IzvjestajScreenState extends State<IzvjestajScreen> {
  late Ordinacija ordinacija;
  late Izvjestaj izvjestaj;
  bool isDataLoaded = false;

  Future<Izvjestaj> fetchInfo(BuildContext context) async {
    var provider = Provider.of<OrdinacijaProvider>(context, listen: false);
    var fetchedInfo = await provider.getIzvjestaj(widget.ordinacijaId);

    return fetchedInfo;
  }

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var provider = Provider.of<OrdinacijaProvider>(context, listen: false);
    return provider.getById(widget.ordinacijaId);
  }

  void exportToPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            children: [
              pw.Text(
                'Ordinacija',
              ),
              pw.SizedBox(height: 12),
              pw.Text('Naziv: ${ordinacija.naziv}'),
              pw.Text('Adresa: ${ordinacija.adresa}'),
              pw.Text('Broj telefona: ${ordinacija.telefon}'),
              pw.SizedBox(height: 16),
              pw.Text(
                'Statistike',
              ),
              pw.SizedBox(height: 12),
              pw.Text('Ukupno korisnika: ${izvjestaj.ukopnoKorisnika}'),
              pw.Text('Broj doktora: ${izvjestaj.brojDoktora}'),
              pw.Text('Broj pacijenata: ${izvjestaj.brojPacijenta}'),
              pw.Text('Broj rezervacija: ${izvjestaj.brojRezervacija}'),
              pw.Text(
                  'Broj aktivnih rezervacija: ${izvjestaj.brojAktinihRezervacija}'),
              pw.Text(
                  'Broj neaktivnih rezervacija: ${izvjestaj.brojNeaktivnihRezervacija}'),
              pw.Text('Broj nalaza: ${izvjestaj.brojNalaza}'),
              pw.Text('Broj poklon bonova: ${izvjestaj.brojPoklonBonova}'),
            ],
          ),
        ),
      ),
    );

    final output = 'izvjestaj_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(output);
    file.writeAsBytesSync(await pdf.save());
    OpenFile.open(file.path);
  }

  @override
  void initState() {
    super.initState();
    fetchData(context);
  }

  Future<void> fetchData(BuildContext context) async {
    try {
      izvjestaj = await fetchInfo(context);
      ordinacija = await fetchOrdinacija(context);

      setState(() {
        isDataLoaded = true;
      });
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izvještaj'),
      ),
      body: Center(
        child: isDataLoaded
            ? ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  buildInfoCard(
                    title: "Ordinacija",
                    items: [
                      InfoItem("Naziv", ordinacija.naziv),
                      InfoItem("Adresa", ordinacija.adresa),
                      InfoItem("Broj telefona", ordinacija.telefon),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  buildInfoCard(
                    title: "Statistike",
                    items: [
                      InfoItem("Ukupno korisnika",
                          izvjestaj.ukopnoKorisnika.toString()),
                      InfoItem(
                          "Broj doktora", izvjestaj.brojDoktora.toString()),
                      InfoItem("Broj pacijenata",
                          izvjestaj.brojPacijenta.toString()),
                      InfoItem("Broj rezervacija",
                          izvjestaj.brojRezervacija.toString()),
                      InfoItem("Broj aktivnih rezervacija",
                          izvjestaj.brojAktinihRezervacija.toString()),
                      InfoItem("Broj neaktivnih rezervacija",
                          izvjestaj.brojNeaktivnihRezervacija.toString()),
                      InfoItem("Broj nalaza", izvjestaj.brojNalaza.toString()),
                      InfoItem("Broj poklon bonova",
                          izvjestaj.brojPoklonBonova.toString()),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showConfirmationDialog(context, exportToPdf);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/pdf.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                              width:
                                  8), // Optional space between image and text
                          Text('Snimi PDF'),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  Future<void> showConfirmationDialog(
      BuildContext context, VoidCallback onConfirm) async {
    bool? shouldOpen = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potvrda'),
          content: Text('Da li želite otvoriti PDF fajl?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('DA'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('NE'),
            ),
          ],
        );
      },
    );

    if (shouldOpen != null && shouldOpen) {
      // If the user selected 'DA', then call the exportToPdf function
      onConfirm();
    }
  }

  Widget buildInfoCard({required String title, required List<InfoItem> items}) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Courier',
              ),
            ),
            SizedBox(height: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return buildInfoItem(item.label, item.value);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem {
  final String label;
  final String value;

  InfoItem(this.label, this.value);
}
