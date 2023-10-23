import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/Doktori/doktori_ordinacija.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pacijenti/pacijenti_ordinacija_lista.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pokon%20bon/poklon_bon.dart';
import 'package:estomatolog_admin/screens/ordinacija/ordinacija_info.dart';
import 'package:estomatolog_admin/screens/ordinacija/Rezervacije/rezervacija_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/utils/util.dart';
import 'package:provider/provider.dart';

class OrdinacijaHomeScreen extends StatelessWidget {
  final int ordinacijaId;
  const OrdinacijaHomeScreen({super.key, required this.ordinacijaId});
  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var pacijentProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var ordinacija = await pacijentProvider.getById(ordinacijaId);
    return ordinacija;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Ordinacija>(
          future: fetchOrdinacija(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Lista nalaza - Učitavanje...');
            } else if (snapshot.hasError) {
              return const Text('Greška pri dohvatu podataka o ordinaciji.');
            } else if (!snapshot.hasData) {
              return const Text('Nema dostupnih podataka o pacijentu.');
            } else {
              Ordinacija ordinacija = snapshot.data!;
              return Text(
                  'Izbornik ordinacije: - ${ordinacija.naziv} ${ordinacija.adresa} ');
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
                    'Prijavljeni korisnik: ${Authorization.korisnickoIme}',
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
              icon: Icons.people,
              title: 'Pacijenti',
              ordinacijaId: ordinacijaId),
          CardItem(
              icon: Icons.medical_services,
              title: 'Doktori',
              ordinacijaId: ordinacijaId),
          CardItem(
              icon: Icons.note_add,
              title: 'Rezervacije',
              ordinacijaId: ordinacijaId),
          CardItem(
              icon: Icons.rate_review,
              title: 'Ordinacija info',
              ordinacijaId: ordinacijaId),
          CardItem(
              icon: Icons.wallet_giftcard,
              title: 'Poklon bonovi',
              ordinacijaId: ordinacijaId),
          CardItem(
              icon: Icons.report,
              title: 'Izvještaji',
              ordinacijaId: ordinacijaId),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int ordinacijaId;

  const CardItem(
      {super.key, required this.icon, required this.title, required this.ordinacijaId});

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
            if (icon == Icons.medical_services && title == 'Doktori') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DoctorsOrdinacijaScreen(ordinacijaId: ordinacijaId)),
              );
            } else if (icon == Icons.people && title == 'Pacijenti') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PacijentOrdinacijaScreen(ordinacijaId: ordinacijaId)),
              );
            } else if (icon == Icons.rate_review &&
                title == 'Ordinacija info') {
              print(ordinacijaId);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrdinacijaDetaljiScreen(
                          ordinacijaId: ordinacijaId,
                        )),
              );
            } else if (icon == Icons.note_add && title == 'Rezervacije') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RezervacijaScreen(ordinacijaId: ordinacijaId)),
              );
            } else if (icon == Icons.wallet_giftcard &&
                title == 'Poklon bonovi') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PoklonBonScreen(ordinacijaId: ordinacijaId)),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60.0, color: Colors.blue),
              const SizedBox(height: 10.0),
              Text(title, style: const TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
