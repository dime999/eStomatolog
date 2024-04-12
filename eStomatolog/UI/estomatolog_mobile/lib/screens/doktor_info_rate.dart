import 'package:animate_do/animate_do.dart';
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
        // ignore: use_build_context_synchronously
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
          title: const Text(
            'Informacije o doktoru',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<int>>(
          future: fetchSlikeIds(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<int> slikeIds = snapshot.data!;
              return ListView(
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                        child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: slikeIds.isNotEmpty
                          ? NetworkImage(
                              "http://10.0.2.2:7265/SlikaStream?slikaId=${slikeIds[0]}")
                          : const AssetImage('assets/images/doctor_avatar.jpg')
                              as ImageProvider<Object>,
                    )),
                  ),
                  FadeInDown(
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        height: 2.0,
                        thickness: 1.0,
                      ),
                    ),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildInfoText('Ime i prezime'),
                                          _buildDoctorInforamtionText(
                                              "${imeController.text} ${prezimeController.text}"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => OcjeneScreen(
                                                    doktorId: widget.doktorId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Prikazi sve',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 12),
                                            ),
                                          ),
                                          prikaziZvjezdice((widget.ocjena)),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildInfoText('Email'),
                                  _buildDoctorInforamtionText(
                                      emailController.text),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  _buildInfoText('Telefon'),
                                  _buildDoctorInforamtionText(
                                      telefonController.text),
                                  const SizedBox(height: 16.0),
                                  const Text(
                                    'Specijalizacije:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Column(
                                    children: List.generate(
                                      naziviSpecijalizacija.length,
                                      (index) {
                                        Color color =
                                            Color.fromRGBO(8, 175, 19, 1);

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
                                          child: Text(
                                            naziviSpecijalizacija[index],
                                            style: TextStyle(color: color),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Divider(
                                      height: 1.0,
                                    ),
                                  ),
                                  const Text(
                                    'Ocjeni ovog doktora:',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  RatingBar.builder(
                                    initialRating: ocjenaKorisnika,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 25.0,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      ocjenaKorisnika = rating.roundToDouble();
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  Container(
                                    height: 50,
                                    child: TextFormField(
                                      controller: opisController,
                                      decoration: const InputDecoration(
                                        labelText: 'Dodajte opis (opcionalno)',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24.0),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        try {
                                          int pretvorenaOcjena =
                                              ocjenaKorisnika.round();
                                          Ocjene ocjena = Ocjene(
                                              widget.doktorId,
                                              pacijent.id,
                                              DateTime.now(),
                                              pretvorenaOcjena,
                                              opisController.text);
                                          await _ocjeneProvider.insert(ocjena);
                                          // ignore: use_build_context_synchronously
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
                                            const SnackBar(
                                                content: Text(
                                                    "Moguće je ocijenti doktora samo jednom.")),
                                          );
                                        }
                                      },
                                      child: const Text('Dodaj ocjenu'),
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
    zvjezdice.add(const Icon(
      Icons.star,
      color: Colors.yellow,
      size: 20,
    ));
  }
  if (imaPolaZvjezdice) {
    zvjezdice.add(const Icon(Icons.star_half, color: Colors.yellow));
  }

  return Row(children: zvjezdice);
}

Widget _buildInfoText(String text) {
  return FadeInRight(
    delay: const Duration(milliseconds: 600),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.grey[400]),
    ),
  );
}

Widget _buildDoctorInforamtionText(String text) {
  return FadeInRight(
    delay: const Duration(milliseconds: 600),
    child: Text(
      text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
  );
}
