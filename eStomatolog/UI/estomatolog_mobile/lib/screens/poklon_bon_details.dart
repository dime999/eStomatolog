import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_insert.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_usluge.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bonovi_lista.dart';
import 'package:estomatolog_mobile/models/validator.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/poklon_bon_provider.dart';
import 'package:estomatolog_mobile/screens/kreditna_kartica_lista.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  bool _isImeValid = true;

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Poklon bon info',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/bon_banner$valueSlike.png"),
                            fit: BoxFit.cover,
                          ),
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
                                    _buildFormField('Odabrani poklon bon:',
                                        "${bonovi[widget.index].naziv} $valueSlike"),
                                    _buildFormField('Cijena poklon bona:',
                                        "${bonovi[widget.index].cijena}KM"),
                                    const SizedBox(height: 16.0),
                                    Text(
                                      'Usluge koje se mogu dobiti uz ovaj poklon bon:',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Column(
                                      children: List.generate(
                                        bonoviUsluge.length,
                                        (index) {
                                          int servicePrice =
                                              bonoviUsluge[index].cijena;
                                          Color color =
                                              servicePrice <= giftCardPrice
                                                  ? Colors.green
                                                  : Colors.red;
                                          IconData icon =
                                              servicePrice <= giftCardPrice
                                                  ? Icons.check
                                                  : Icons.close;
                                          Color iconColor = Colors.white;

                                          return Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${bonoviUsluge[index].naziv}  / ${bonoviUsluge[index].cijena}KM",
                                                  style: TextStyle(
                                                      color: color,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.credit_card,
                              color: Colors.white,
                              size: 35,
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
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Ime i prezime osobe koja će iskorititi bon:',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          width: 350,
                                          height: 90,
                                          child: TextField(
                                            controller: _nazivOsobe,
                                            decoration: InputDecoration(
                                              labelText:
                                                  "Ime i prezime osobe koja će koristiti bon:",
                                              border:
                                                  const OutlineInputBorder(),
                                              errorText: _isImeValid
                                                  ? null
                                                  : 'Unesite ispravne podatke za ime i prezime',
                                            ),
                                            onChanged: (value) {
                                              bool isValid = Validators
                                                  .validirajImeiPrezime(value);
                                              setState(() {
                                                _isImeValid = isValid;
                                              });
                                            },
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Iznos: ',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${bonovi[widget.index].cijena} KM',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Ordinacija: ',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ordinacija.naziv,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Vaše korisničko ime: ',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${(Authorization.korisnickoIme)}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        RichText(
                                          text: const TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Način plaćanja: ',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Lično (keš)',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(22.0),
                                            child: Container(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: _isImeValid
                                                    ? () async {
                                                        int? iznos =
                                                            int.tryParse(bonovi[
                                                                    widget
                                                                        .index]
                                                                .cijena);
                                                        _poklonBonProvider =
                                                            Provider.of<
                                                                    PoklonBonProvider>(
                                                                context,
                                                                listen: false);
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
                                                                DateTime.now(),
                                                                " ",
                                                                false);

                                                        try {
                                                          _poklonBonProvider
                                                              .insert(
                                                                  poklonBon);
                                                          Navigator.of(context)
                                                              .pop();
                                                          // ignore: use_build_context_synchronously
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Row(
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
                                                                content: const Text(
                                                                    'Narudžba je uspešno potvrđena!'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'OK'),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        } catch (e) {
                                                          print(
                                                              "Greška prilikom dodavanja: $e");
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      }
                                                    : null,
                                                child: const Text(
                                                    'Naruči poklon bon'),
                                              ),
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
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: TextStyle(
          //     fontSize: 15.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.grey[400],
          //   ),
          // ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20.0,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
