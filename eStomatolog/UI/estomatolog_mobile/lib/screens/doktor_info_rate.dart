import 'package:estomatolog_mobile/models/Doktor/doktor.dart';
import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/Ocjene/ocjene.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/slika_provider.dart';
import 'package:estomatolog_mobile/screens/ocjene_screen.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_mobile/providers/doktor_specijalizacije_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor_specijalizacija.dart';

class DoktorInfoScreen extends StatefulWidget {
  final int korisnikId;
  final int doktorId;
  final double ocjena;

  const DoktorInfoScreen(
      {required this.korisnikId,
      required this.doktorId,
      required this.ocjena,
      Key? key})
      : super(key: key);

  @override
  _DoktorInfoScreenState createState() => _DoktorInfoScreenState();
}

class _DoktorInfoScreenState extends State<DoktorInfoScreen> {
  late int korisnikId;
  late Korisnik korisnik;
  List<DoktorSpecijalizacija> specijalizacijeDoktora = [];
  List<String> naziviSpecijalizacija = [];
  late Pacijent pacijent;
  List<int> slikeIds = [];

  @override
  void initState() {
    super.initState();
    korisnikId = widget.korisnikId;
    fetchUsers(context);
  }

  @override
  void dispose() {
    opisController.dispose();
    super.dispose();
  }

  Future<Korisnik> fetchUsers(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedUser = await korisnikProvider.getById(korisnikId);
    var fetchedPacijent =
        await pacijentProvider.getByKorisnikId(Authorization.korisnikId);

    setState(() {
      korisnik = fetchedUser;
      pacijent = fetchedPacijent;
      imeController.text = korisnik.ime;
      prezimeController.text = korisnik.prezime;
      emailController.text = korisnik.email ?? '';
      telefonController.text = korisnik.telefon ?? '';
      status = korisnik.status ?? true;
    });

    var provider =
        Provider.of<DoktorSpecijalizacijaProvider>(context, listen: false);
    var fetchedSpec = await provider.getByDoktorId(widget.doktorId);
    naziviSpecijalizacija = fetchedSpec.result
        .map((specijalizacija) => specijalizacija.specijalizacijaNaziv ?? '')
        .toList();

    setState(() {
      specijalizacijeDoktora = fetchedSpec.result;
    });

    return korisnik;
  }

  Future<Doktor> fetchDoktor(BuildContext context) async {
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var fetchedDoktor = await doktorProvider.getByKorisnikId(widget.korisnikId);
    return fetchedDoktor;
  }

  Future<List<int>> fetchSlikeIds(BuildContext context) async {
    var slikeProvider = Provider.of<SlikaProvider>(context, listen: false);
    var fetchedSlike = await slikeProvider.getDoktorSlika(widget.doktorId);
    return fetchedSlike;
  }

  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController opisController = TextEditingController();

  double ocjenaKorisnika = 0;
  bool status = true;
  late OcjeneProvider _ocjeneProvider;

  @override
  Widget build(BuildContext context) {
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Informacije o doktoru'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<int>>(
          future: fetchSlikeIds(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<int> slikeIds = snapshot.data!;
              return ListView(
                children: [
                  Container(
                    height: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/doctor_wallpaper.jpg"),
                      fit: BoxFit.cover,
                    )),
                    child: Center(
                        child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: slikeIds.isNotEmpty
                          ? NetworkImage(
                              "http://10.0.2.2:7265/SlikaStream?slikaId=${slikeIds[0]}")
                          : AssetImage('assets/images/doctor_avatar.jpg')
                              as ImageProvider<Object>,
                    )),
                  ),
                  Padding(
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
                                  _buildFormField('Ime', imeController.text),
                                  const SizedBox(height: 16.0),
                                  _buildFormField(
                                      'Prezime', prezimeController.text),
                                  const SizedBox(height: 16.0),
                                  _buildFormField(
                                      'Email', emailController.text),
                                  const SizedBox(height: 16.0),
                                  _buildFormField(
                                      'Telefon', telefonController.text),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Specijalizacije:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 220, 219, 219)),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: List.generate(
                                        naziviSpecijalizacija.length,
                                        (index) {
                                          Color color =
                                              Color.fromRGBO(8, 175, 19, 1);

                                          return Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: color.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
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
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Prosječna ocjena doktora: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          prikaziZvjezdice((widget.ocjena)),
                                        ],
                                      ),
                                      Text(
                                        widget.ocjena.toStringAsFixed(1),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Pogledaj sve ocjene doktora: ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => OcjeneScreen(
                                                doktorId: widget.doktorId,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text('Ocjene'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24.0),
                                  Text(
                                    'Ocjeni ovog doktora:',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                      ocjenaKorisnika = rating.roundToDouble();
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: opisController,
                                    decoration: InputDecoration(
                                      labelText: 'Dodajte opis (opcionalno)',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        int pretvorenaOcjena =
                                            ocjenaKorisnika.round();
                                        Ocjene ocjena = new Ocjene(
                                            widget.doktorId,
                                            pacijent.id,
                                            DateTime.now(),
                                            pretvorenaOcjena,
                                            opisController.text);
                                        await _ocjeneProvider.insert(ocjena);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Uspješno ste ocijenili doktora sa ocjenom $pretvorenaOcjena')),
                                        );

                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Moguće je ocijenti doktora samo jednom.")),
                                        );
                                      }
                                    },
                                    child: Text('Dodaj ocjenu'),
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
                ],
              );
            }
          },
        ));
  }
}

Widget prikaziZvjezdice(double prosjek) {
  int cijelaZvjezdica = prosjek.floor();
  bool imaPolaZvjezdice = (prosjek - cijelaZvjezdica) >= 0.5;

  List<Widget> zvjezdice = [];
  for (int i = 0; i < cijelaZvjezdica; i++) {
    zvjezdice.add(Icon(
      Icons.star,
      color: Colors.yellow,
      size: 40,
    ));
  }
  if (imaPolaZvjezdice) {
    zvjezdice.add(Icon(Icons.star_half, color: Colors.yellow));
  }

  return Row(children: zvjezdice);
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
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
