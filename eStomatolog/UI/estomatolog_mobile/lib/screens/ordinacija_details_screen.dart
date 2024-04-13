import 'dart:ui';
import 'package:estomatolog_mobile/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/slika_provider.dart';
import 'package:estomatolog_mobile/screens/doktor_info_rate.dart';
import 'package:estomatolog_mobile/screens/doktori_lista_screen.dart';
import 'package:estomatolog_mobile/screens/galerija_screen.dart';
import 'package:estomatolog_mobile/screens/poklon_bon.dart';
import 'package:estomatolog_mobile/screens/rezervacija_screen.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrdinacijaDetailScreen extends StatefulWidget {
  final int ordinacijaId;
  const OrdinacijaDetailScreen({super.key, required this.ordinacijaId});

  @override
  State<OrdinacijaDetailScreen> createState() => _OrdinacijaDetailScreenState();
}

class _OrdinacijaDetailScreenState extends State<OrdinacijaDetailScreen> {
  bool isSelected = false;
  Ordinacija? ordinacija;

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var pacijentProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var ordinacija = await pacijentProvider.getById(widget.ordinacijaId);
    return ordinacija;
  }

  Future<List<DoktorOrdinacija>> fetchDoctors(
      BuildContext context, String searchQuery) async {
    var doktorProvider =
        Provider.of<DoktorOrdinacijaProvider>(context, listen: false);
    var fetchedDoctors =
        await doktorProvider.getByOrdinacijaId(widget.ordinacijaId);

    for (var doktor in fetchedDoctors.result) {
      var providerOcjene = Provider.of<OcjeneProvider>(context, listen: false);
      var fetchedOcjene = await providerOcjene.get(doktor.doktorId);

      doktor.ocjene
          .addAll(fetchedOcjene.result.map((ocjena) => ocjena.ocjena).toList());
    }

    var filteredDoktori = fetchedDoctors.result.where((doktor) {
      var ime = doktor.doktorIme?.toLowerCase() ?? '';
      var prezime = doktor.doktorPrezime?.toLowerCase() ?? '';
      return ime.contains(searchQuery.toLowerCase()) ||
          prezime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredDoktori;
  }

  Future<List<int>> fetchOrdinacijaSlike(BuildContext context) async {
    var ordinacijaSlikeProvider =
        Provider.of<SlikaProvider>(context, listen: false);
    var fetchedOrdinacije =
        await ordinacijaSlikeProvider.getSlikeIds(widget.ordinacijaId);
    return fetchedOrdinacije;
  }

  @override
  void initState() {
    super.initState();
    _fetchOrdinacijaData();
  }

  _fetchOrdinacijaData() async {
    var fetchedOrdinacija = await fetchOrdinacija(context);
    setState(() {
      ordinacija = fetchedOrdinacija;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FutureBuilder<Ordinacija>(
          future: fetchOrdinacija(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              var ordinacija = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              FutureBuilder<List<int>>(
                                future: fetchOrdinacijaSlike(context),
                                builder: (context, snapshot) {
                                  List<int> slikeIds = snapshot.data ?? [];
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
                                    return SizedBox(
                                      width: width,
                                      height: height * 0.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.network(
                                          "http://10.0.2.2:7265/SlikaStream?slikaId=${slikeIds[0]}",
                                          width: 100,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Positioned(
                                top: 40,
                                left: 20,
                                right: 20,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ordinacija!.naziv,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 60,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            RatingBar.builder(
                                              initialRating: 4.5,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 18,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.locationDot,
                                          color: Colors.blue,
                                          size: 15,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          ordinacija!.adresa,
                                          style: const TextStyle(
                                              color: Colors.black38,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.mobileScreenButton,
                                          color: Colors.blue,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          ordinacija!.telefon,
                                          style: const TextStyle(
                                              color: Colors.black38,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Opis",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ordinacija != null
                                      ? 'Naša ordinacija se zove ${ordinacija!.naziv} i nalazimo se na adresi ${ordinacija!.adresa}. Naše ljubazno osoblje će vas primiti i riješiti bilo koji problem koji imate sa oralnim zdravljem. '
                                      : 'Podaci o ordinaciji nisu dostupni',
                                  style: const TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Lista doktora",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 110,
                                  child: FutureBuilder<List<DoktorOrdinacija>>(
                                    future: fetchDoctors(context, ""),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            final doktor =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: _doctorListItem(doktor),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: height * 0.12,
                            ),
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Galerija",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 200,
                                  child: FutureBuilder<List<int>>(
                                    future: fetchOrdinacijaSlike(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      } else {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            List<int> slikeIds = snapshot.data!;
                                            return Card(
                                              color: Colors.transparent,
                                              elevation: 0,
                                              child: Container(
                                                width: 200,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Image.network(
                                                  "http://10.0.2.2:7265/SlikaStream?slikaId=${slikeIds[index]}",
                                                  width: 100,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
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
                      child: Container(
                        width: width,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(200),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PoklonBonScreen(
                                      ordinacijaId: widget.ordinacijaId,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: height * 0.068,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.blue[600],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Boja sjene
                                      spreadRadius: 2, // Proširenje sjene
                                      blurRadius: 5, // Zamućenje sjene
                                      offset: Offset(0, 3), // Pomak sjene
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.gift,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RezervacijaScreen(
                                        korisnikId: Authorization.korisnikId,
                                        ordinacijaId: widget.ordinacijaId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: height * 0.068,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.3), // Boja sjene
                                        spreadRadius: 2, // Proširenje sjene
                                        blurRadius: 5, // Zamućenje sjene
                                        offset: Offset(0, 3), // Pomak sjene
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Rezervisi termin",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double izracunajProsjecnuOcjenu(List<int> ocjene) {
    if (ocjene.isEmpty) {
      return 0.0;
    }
    double sumaOcjena =
        ocjene.map((ocjena) => ocjena.toDouble()).reduce((a, b) => a + b);
    double prosjek = sumaOcjena / ocjene.length;
    return prosjek;
  }

  Widget _doctorListItem(DoktorOrdinacija doktor) {
    var prosjecnaOcjena = izracunajProsjecnuOcjenu(doktor.ocjene);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoktorInfoScreen(
              korisnikId: doktor.korisnikId,
              doktorId: doktor.doktorId,
              ocjena: prosjecnaOcjena,
            ),
          ),
        ).then((value) {
          setState(() {
            fetchDoctors(context, "");
          });
        });
      },
      child: Container(
        width: 80,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Boja sjene
                      spreadRadius: 2, // Proširenje sjene
                      blurRadius: 5, // Zamućenje sjene
                      offset: Offset(0, 3), // Pomak sjene
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 10,
                  backgroundImage:
                      AssetImage('assets/images/doctor_avatar.jpg'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
                child: Column(
                  children: [
                    Text(
                      "${doktor.doktorIme!} ${doktor.doktorPrezime!}",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(String label, String imagePath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: null),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 70,
                height: 70,
              ),
              Text(
                label,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
