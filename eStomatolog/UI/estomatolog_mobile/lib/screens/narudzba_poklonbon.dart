import 'dart:math';

import 'package:estomatolog_mobile/models/KorisnikKartica/korisnik_kartica.dart';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_insert.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/poklon_bon_provider.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:provider/provider.dart';

class NaruciPoklonBonScreen extends StatefulWidget {
  final int cijena;
  final KorisnikKartica kartica;
  final Ordinacija ordinacija;

  NaruciPoklonBonScreen(
      {required this.cijena, required this.kartica, required this.ordinacija});

  @override
  _NaruciPoklonBonScreenState createState() => _NaruciPoklonBonScreenState();
}

class _NaruciPoklonBonScreenState extends State<NaruciPoklonBonScreen> {
  TextEditingController _nazivOsobe = TextEditingController();
  late PoklonBonProvider _poklonBonProvider;
  late Pacijent pacijent;

  String generateRandomCode() {
    Random random = Random();
    int code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedPacijent =
        await pacijentProvider.getByKorisnikId(Authorization.korisnikId);
    pacijent = fetchedPacijent;
    return pacijent;
  }

  @override
  void initState() {
    super.initState();
    fetchPacijent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Naruči poklon bon'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ime i prezime osobe koja će iskoristiti bon:',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 22),
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Ime i prezime',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    controller: _nazivOsobe,
                  ),
                ),
                SizedBox(height: 25),
                RichTextInfo(text: 'Iznos:', value: '${widget.cijena} KM'),
                SizedBox(height: 25),
                RichTextInfo(
                    text: 'Ordinacija:', value: '${widget.ordinacija.naziv}'),
                SizedBox(height: 25),
                RichTextInfo(
                    text: 'Vaše korisničko ime:',
                    value: '${Authorization.korisnickoIme}'),
                SizedBox(height: 25),
                RichTextInfo(text: 'Način plaćanja:', value: 'Kartica'),
                SizedBox(height: 25),
                RichTextInfo(
                    text: 'Vrsta kartice:', value: widget.kartica.vrstaKartica),
                SizedBox(height: 25),
                RichTextInfo(
                    text: 'Broj kartice:', value: widget.kartica.brojKartice),
                SizedBox(height: 25),
                RichTextInfo(
                    text: 'Datum isteka kartice:',
                    value: widget.kartica.datumIsteka),
                SizedBox(height: 65),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          var imePrezime = _nazivOsobe.text;
                          String randomCode = generateRandomCode();

                          try {
                            _poklonBonProvider = Provider.of<PoklonBonProvider>(
                                context,
                                listen: false);
                            PoklonBonInsert poklonBon = PoklonBonInsert(
                                randomCode,
                                widget.cijena,
                                pacijent.id,
                                widget.ordinacija.ordinacijaId,
                                imePrezime,
                                true,
                                "",
                                DateTime.now(),
                                " ",
                                false);

                            _poklonBonProvider.insert(poklonBon);
                            _showValidDialog(
                              randomCode,
                              context,
                            );
                          } catch (e) {}
                        },
                        icon: Icon(Icons.shopping_cart, size: 22),
                        label: Text('Plati', style: TextStyle(fontSize: 24)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

_showValidDialog(
  String kod,
  BuildContext context,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Text('Narudzba poklon bona'),
          ],
        ),
        content: Text(
            'Uspješno ste platili poklon bon, ovo je kod za aktivaciju "${kod}" !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

class RichTextInfo extends StatelessWidget {
  final String text;
  final String value;

  RichTextInfo({required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$text ',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '$value',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
