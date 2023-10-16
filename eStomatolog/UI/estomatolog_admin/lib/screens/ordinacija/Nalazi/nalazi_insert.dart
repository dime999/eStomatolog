import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/models/Korisnik/korisnik_basic.dart';
import 'package:estomatolog_admin/models/Nalaz/nalaz_insert.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/providers/nalaz_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
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

  Future<KorisnikBasic> fetchDoktor(BuildContext context) async {
    var korisickiProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    KorisnikBasic doktor =
        await korisickiProvider.getByKorisickoIme(Authorization.korisnickoIme);
    return doktor;
  }

  Future<Doktor> fetchDoktorId(BuildContext context) async {
    var doktorProvicer = Provider.of<DoktorProvider>(context, listen: false);
    KorisnikBasic korisnik = await fetchDoktor(context);
    int korisnikId = korisnik.korisnikId;
    Doktor doktor = await doktorProvicer.getByKorisnikId(korisnikId);
    return doktor;
  }

  late NalazProvider _nalazProvider;

  @override
  Widget build(BuildContext context) {
    _nalazProvider = Provider.of<NalazProvider>(context, listen: false);
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
                  'Dodaj nalaz za:  ${pacijent.ime} ${pacijent.prezime} ');
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
                try {
                  Doktor doktor = await fetchDoktorId(context);
                  Pacijent pacijent = await fetchPacijent(context);
                  NalazInsert nalaz = NalazInsert(doktor.id, pacijent.id,
                      opisController.text, DateTime.now());
                  print(nalaz.opis);
                  await _nalazProvider.insert(nalaz);
                } catch (e) {
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
