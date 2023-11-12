import 'dart:ui';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/screens/doktori_lista_screen.dart';
import 'package:estomatolog_mobile/screens/galerija_screen.dart';
import 'package:estomatolog_mobile/screens/poklon_bon.dart';
import 'package:estomatolog_mobile/screens/rezervacija_screen.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.asset(
                'assets/images/klinika2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            buttonArrow(context),
            scroll(isSelected),
          ],
        ),
      ),
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
            borderRadius: BorderRadius.circular(20),
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

  Widget scroll(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(top: 170),
      child: Container(
        height: 600,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 35,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Naziv: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 18.0,
                      ),
                    ),
                    TextSpan(
                      text: ordinacija?.naziv ?? '',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Adresa: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: ordinacija?.adresa ?? '',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ],
                ),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Broj: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text: ordinacija?.telefon ?? '',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ],
                ),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(
                  height: 4,
                ),
              ),
              const Text(
                "Opis",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ordinacija != null
                    ? 'Naša ordinacija se zove ${ordinacija!.naziv} i nalazimo se na adresi ${ordinacija!.adresa}. Naše ljubazno osoblje će vas primiti i riješiti bilo koji problem koji imate sa oralnim zdravljem. '
                    : 'Podaci o ordinaciji nisu dostupni',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 0,
                children: [
                  _buildItem('Rezervacija', 'assets/images/reservation.png',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RezervacijaScreen(
                          korisnikId: Authorization.korisnikId,
                          ordinacijaId: widget.ordinacijaId,
                        ),
                      ),
                    );
                  }),
                  _buildItem('Galerija', 'assets/images/galerija.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GalerijaScreen(
                          ordinacijaId: widget.ordinacijaId,
                        ),
                      ),
                    );
                  }),
                  _buildItem('Lista doktora', 'assets/images/lista_doktor.png',
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorsOrdinacijaScreen(
                          ordinacijaId: widget.ordinacijaId,
                        ),
                      ),
                    );
                  }),
                  _buildItem('Poklon bonovi', 'assets/images/poklon.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RezervacijaScreen(
                          korisnikId: Authorization.korisnikId,
                          ordinacijaId: widget.ordinacijaId,
                        ),
                      ),
                    );
                  }),
                ],
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
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
