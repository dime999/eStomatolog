import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_insert.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_usluge.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bonovi_lista.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/poklon_bon_provider.dart';
import 'package:estomatolog_mobile/screens/kreditna_kartica_lista.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoklonBonInfoScreen extends StatefulWidget {
  final int index;
  final int ordinacijaId;

  const PoklonBonInfoScreen(
      {required this.index, required this.ordinacijaId, Key? key})
      : super(key: key);

  @override
  _PoklonBonInfoScreenState createState() => _PoklonBonInfoScreenState();
}

class _PoklonBonInfoScreenState extends State<PoklonBonInfoScreen> {
  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController opisController = TextEditingController();

  double ocjenaKorisnika = 0;
  bool placeno = false;
  late int slikaIndex;
  late String valueSlike;
  late int giftCardPrice;
  late PoklonBonProvider _poklonBonProvider;
  late Pacijent pacijent;
  final TextEditingController _nazivOsobe = TextEditingController();

  late Ordinacija ordinacija;

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var pacijentProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var ordinacija = await pacijentProvider.getById(widget.ordinacijaId);
    return ordinacija;
  }

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedPacijent =
        await pacijentProvider.getByKorisnikId(Authorization.korisnikId);
    pacijent = fetchedPacijent;
    return pacijent;
  }

  _fetchOrdinacijaData() async {
    var fetchedOrdinacija = await fetchOrdinacija(context);
    setState(() {
      ordinacija = fetchedOrdinacija;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchOrdinacijaData();
    fetchPacijent(context);
    slikaIndex = widget.index + 1;
    valueSlike = slikaIndex.toString();
    giftCardPrice = int.parse(bonovi[widget.index].cijena);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poklon bon info'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("assets/images/bon_banner${valueSlike}.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormField(
                                'Odabrani poklon bon:',
                                (bonovi[widget.index].naziv) +
                                    " " +
                                    valueSlike),
                            const SizedBox(height: 12.0),
                            _buildFormField('Cijena poklon bona:',
                                (bonovi[widget.index].cijena) + "KM"),
                            const SizedBox(height: 16.0),
                            Text(
                              'Usluge koje se mogu dobiti uz ovaj poklon bon:',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 220, 219, 219),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: List.generate(
                                  bonoviUsluge.length,
                                  (index) {
                                    int servicePrice =
                                        bonoviUsluge[index].cijena;
                                    Color color = servicePrice <= giftCardPrice
                                        ? Colors.green
                                        : Colors.red;
                                    IconData icon =
                                        servicePrice <= giftCardPrice
                                            ? Icons.check
                                            : Icons.close;
                                    Color iconColor = Colors.white;

                                    return Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bonoviUsluge[index].naziv +
                                                "  / " +
                                                bonoviUsluge[index]
                                                    .cijena
                                                    .toString() +
                                                "KM",
                                            style: TextStyle(color: color),
                                          ),
                                          Icon(
                                            icon,
                                            color: iconColor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Container(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.0),
                            Center(
                              child: Text(
                                'Odaberite način plaćanja',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => KarticePlacanjeScreen(
                                          cijena: giftCardPrice,
                                          ordinacija: ordinacija,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ime i prezime osobe koja će iskorititi bon:',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  Container(
                                                    width: 300,
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Ime i prezime',
                                                        prefixIcon:
                                                            Icon(Icons.email),
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      controller: _nazivOsobe,
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Iznos: ',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${bonovi[widget.index].cijena} KM',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: 'Ordinacija: ',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${ordinacija.naziv}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'Vaše korisničko ime: ',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${(Authorization.korisnickoIme)}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'Način plaćanja: ',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: 'Lično (keš)',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 22),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              22.0),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          int? iznos =
                                                              int.tryParse(
                                                                  bonovi[widget
                                                                          .index]
                                                                      .cijena);
                                                          _poklonBonProvider =
                                                              Provider.of<
                                                                      PoklonBonProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          PoklonBonInsert
                                                              poklonBon =
                                                              PoklonBonInsert(
                                                                  "GENERISATI",
                                                                  iznos,
                                                                  pacijent.id,
                                                                  ordinacija
                                                                      .ordinacijaId,
                                                                  _nazivOsobe
                                                                      .text,
                                                                  false,
                                                                  "",
                                                                  DateTime
                                                                      .now(),
                                                                  " ",
                                                                  false);

                                                          try {
                                                            _poklonBonProvider
                                                                .insert(
                                                                    poklonBon);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            // ignore: use_build_context_synchronously
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                          'Potvrda narudžbe'),
                                                                    ],
                                                                  ),
                                                                  content: Text(
                                                                      'Narudžba je uspešno potvrđena!'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          'OK'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          } catch (e) {
                                                            print(
                                                                "Greška prilikom dodavanja: $e");
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        },
                                                        child: Text(
                                                            'Naruči poklon bon'),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )));
  }

  Widget _buildFormField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 22.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
