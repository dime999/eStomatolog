import 'dart:ui';
import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/providers/ordinacija_provider.dart';
import 'package:estomatolog_mobile/screens/doktori_lista_screen.dart';
import 'package:estomatolog_mobile/screens/galerija_screen.dart';
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
      padding: const EdgeInsets.only(top: 200),
      child: Container(
        height: 700,
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
              Text(
                ordinacija?.naziv ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                ordinacija?.adresa ?? '',
                style: TextStyle(color: Colors.black, fontSize: 15),
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ordinacija != null
                    ? 'Naša ordinacija se zove ${ordinacija!.naziv ?? 'N/A'} i nalazimo se na adresi ${ordinacija!.adresa ?? 'N/A'}. Naše ljubazno osoblje će vas primiti i riješiti bilo koji problem koji imate sa oralnim zdravljem. '
                    : 'Podaci o ordinaciji nisu dostupni',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
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
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildItem('Rezervacija', Icons.event, () {}),
                  _buildItem('Lista doktora', Icons.people, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorsOrdinacijaScreen(
                                ordinacijaId: widget.ordinacijaId,
                              )),
                    );
                  }),
                  _buildItem('Poklon bonovi', Icons.card_giftcard, () {}),
                  _buildItem('Galerija', Icons.image, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GalerijaScreen(
                                ordinacijaId: widget.ordinacijaId,
                              )),
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

  Widget _buildItem(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: Colors.blue,
                ),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}