import 'package:estomatolog_mobile/models/Doktor/doktor.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Ocjene/ocjene.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_mobile/providers/doktor_specijalizacije_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/models/Ocjene/ocjene_datum.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor_specijalizacija.dart';

class DoktorInfoScreen extends StatefulWidget {
  final int korisnikId;

  const DoktorInfoScreen({required this.korisnikId, Key? key})
      : super(key: key);

  @override
  _DoktorInfoScreenState createState() => _DoktorInfoScreenState();
}

class _DoktorInfoScreenState extends State<DoktorInfoScreen> {
  late int korisnikId;
  late Korisnik korisnik;
  late Doktor doktor;
  List<DoktorSpecijalizacija> specijalizacijeDoktora = [];
  List<String> naziviSpecijalizacija = [];
  List<OcjenaDatum> ocjeneDoktora = [];
  List<Ocjene> ocjene = [];
  late Pacijent pacijent;

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedDoktor = await doktorProvider.getByKorisnikId(widget.korisnikId);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    var fetchedPacijent =
        await pacijentProvider.getByKorisnikId(Authorization.korisnikId);

    setState(() {
      korisnik = fetchedUser;
      doktor = fetchedDoktor;
      pacijent = fetchedPacijent;
      imeController.text = korisnik.ime ?? '';
      prezimeController.text = korisnik.prezime ?? '';
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      status = korisnik.status ?? true;
    });

    var provider =
        Provider.of<DoktorSpecijalizacijaProvider>(context, listen: false);
    var fetchedSpec = await provider.getByDoktorId(doktor.id);
    naziviSpecijalizacija = fetchedSpec.result
        .map((specijalizacija) => specijalizacija.specijalizacijaNaziv ?? '')
        .toList();

    var providerOcjene = Provider.of<OcjeneProvider>(context, listen: false);
    var fetchedOcjene = await providerOcjene.get(doktor.id);
    ocjene = fetchedOcjene.result;

    ocjeneDoktora = ocjene.map((ocjena) {
      return OcjenaDatum(ocjena: ocjena.ocjena, datum: ocjena.datum);
    }).toList();

    setState(() {
      specijalizacijeDoktora = fetchedSpec.result;
    });

    return korisnik;
  }

  double izracunajProsjecnuOcjenu(List<OcjenaDatum> ocjene) {
    if (ocjene.isEmpty) {
      return 0.0;
    }
    double sumaOcjena = ocjene
        .map((ocjena) => ocjena.ocjena.toDouble())
        .reduce((a, b) => a + b);
    double prosjek = sumaOcjena / ocjene.length;
    return prosjek;
  }

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  double ocjenaKorisnika = 0;
  bool status = true;
  late OcjeneProvider _ocjeneProvider;
  @override
  Widget build(BuildContext context) {
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacije o doktoru'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                        _buildFormField('Ime', imeController),
                        const SizedBox(height: 16.0),
                        _buildFormField('Prezime', prezimeController),
                        const SizedBox(height: 16.0),
                        _buildFormField('Email', emailController),
                        const SizedBox(height: 16.0),
                        _buildFormField('Telefon', telefonController),
                        const SizedBox(height: 32.0),
                        Text(
                          'Specijalizacije:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: List.generate(
                              naziviSpecijalizacija.length,
                              (index) {
                                Color color = Colors
                                    .primaries[index % Colors.primaries.length];

                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 4.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    naziviSpecijalizacija[index],
                                    style: TextStyle(color: color),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        Text(
                          'Ocjene doktora:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: List.generate(
                              ocjeneDoktora.length,
                              (index) {
                                Color color = Colors
                                    .primaries[index % Colors.primaries.length];

                                return Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 4.0),
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ocjena: " +
                                            ocjeneDoktora[index]
                                                .ocjena
                                                .toString(),
                                        style: TextStyle(color: color),
                                      ),
                                      Text(
                                        "Datum: " +
                                            DateFormat('dd.MM.yyyy')
                                                .format(
                                                    ocjeneDoktora[index].datum)
                                                .toString(),
                                        style: TextStyle(color: color),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Prosječna ocjena doktora: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                prikaziZvjezdice(
                                    izracunajProsjecnuOcjenu(ocjeneDoktora)),
                              ],
                            ),
                            Text(
                              izracunajProsjecnuOcjenu(ocjeneDoktora)
                                  .toStringAsFixed(1),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32.0),
                        const SizedBox(height: 16.0),
                        Text(
                          'Ocjeni ovog doktora:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        RatingBar.builder(
                          initialRating: ocjenaKorisnika,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 40.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ocjenaKorisnika = rating.roundToDouble();
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              int pretvorenaOcjena = ocjenaKorisnika.round();
                              Ocjene ocjena = new Ocjene(doktor.id, pacijent.id,
                                  DateTime.now(), pretvorenaOcjena);
                              await _ocjeneProvider.insert(ocjena);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Uspješno ste ocijenili doktora sa ocjenom $pretvorenaOcjena')),
                              );
                              await fetchUsers(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Moguće je ocijenti doktora samo jednom.")),
                              );
                            }
                          },
                          child: Text('Potvrdi'),
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget prikaziZvjezdice(double prosjek) {
    int cijelaZvjezdica = prosjek.floor();
    bool imaPolaZvjezdice = (prosjek - cijelaZvjezdica) >= 0.5;

    List<Widget> zvjezdice = [];
    for (int i = 0; i < cijelaZvjezdica; i++) {
      zvjezdice.add(Icon(Icons.star, color: Colors.yellow));
    }
    if (imaPolaZvjezdice) {
      zvjezdice.add(Icon(Icons.star_half, color: Colors.yellow));
    }

    return Row(children: zvjezdice);
  }

  Widget _buildFormField(String label, TextEditingController controller,
      {bool isObscure = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: controller,
            obscureText: isObscure,
            textAlign: TextAlign.center,
            readOnly: true,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 35, 87, 220),
                fontFamily: ''),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 179, 177, 177),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
