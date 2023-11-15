import 'package:estomatolog_admin/models/Korisnik/korisnik.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/Nalazi/nalazi_lista.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pacijenti/pacijent_rezervacije.dart';
import 'package:estomatolog_admin/screens/pacijent/edit_pacijent_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:provider/provider.dart';

class PacijentOrdinacijaInfoScreen extends StatelessWidget {
  final int ordinacijaId;
  final int pacijentId;
  final int id;
  const PacijentOrdinacijaInfoScreen(
      {super.key,
      required this.ordinacijaId,
      required this.pacijentId,
      required this.id});

  Future<Korisnik> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getById(pacijentId);
    return pacijent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Korisnik>(
          future: fetchPacijent(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Lista nalaza - Učitavanje...');
            } else if (snapshot.hasError) {
              return const Text('Greška pri dohvatu pacijenta.');
            } else if (!snapshot.hasData) {
              return const Text('Nema dostupnih podataka o pacijentu.');
            } else {
              Korisnik pacijent = snapshot.data!;
              return Text(
                  'Izbornik detalja za pacijenta: - ${pacijent.ime} ${pacijent.prezime} ');
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: Text(
                    'Prijavljeni doktor: ${Authorization.korisnickoIme}',
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CardItem(
            imagePath: 'assets/images/nalaz.jpg',
            title: 'Nalazi',
            ordinacijaId: ordinacijaId,
            pacijentId: pacijentId,
            id: id,
          ),
          CardItem(
            imagePath: 'assets/images/reservation.png',
            title: 'Rezervacije',
            ordinacijaId: ordinacijaId,
            pacijentId: pacijentId,
            id: id,
          ),
          CardItem(
            imagePath: 'assets/images/pacijenti.png',
            title: 'Informacije o pacijentu',
            ordinacijaId: ordinacijaId,
            pacijentId: pacijentId,
            id: id,
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final int ordinacijaId;
  final int pacijentId;
  final int id;

  const CardItem(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.ordinacijaId,
      required this.pacijentId,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: () async {
            if (title == 'Nalazi') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NalaziScreen(pacijentId: pacijentId)),
              );
            } else if (title == 'Rezervacije') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RezervacijeHistorijaScreen(
                          ordinacijaId: ordinacijaId,
                          pacijentId: pacijentId,
                        )),
              );
            } else if (title == 'Informacije o pacijentu') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPacijentScreen(
                          korisnikId: pacijentId,
                          pacijentId: id,
                        )),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 80.0, height: 80.0),
              const SizedBox(height: 10.0),
              Text(title, style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
