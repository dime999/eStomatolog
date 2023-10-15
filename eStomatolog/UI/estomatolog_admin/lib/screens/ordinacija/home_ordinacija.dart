import 'package:estomatolog_admin/screens/doktor/doktori_screen.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pacijenti/pacijenti_ordinacija_lista.dart';
import 'package:estomatolog_admin/screens/ordinacija/ordinacije_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/utils/util.dart';

class OrdinacijaHomeScreen extends StatelessWidget {
  final int ordinacijaId;
  OrdinacijaHomeScreen({required this.ordinacijaId});
  @override
  Widget build(BuildContext context) {
    print(ordinacijaId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Izbornik ordinacije'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: Text(
                    'Prijavljeni korisnik: ${Authorization.korisnickoIme}',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
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
              title: 'Recenzije',
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

  CardItem(
      {required this.icon, required this.title, required this.ordinacijaId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
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
                MaterialPageRoute(builder: (context) => DoctorsScreen()),
              );
            } else if (icon == Icons.people && title == 'Pacijenti') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PacijentOrdinacijaScreen(ordinacijaId: ordinacijaId)),
              );
            } else if (icon == Icons.local_hospital && title == 'Ordinacije') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrdinacijaScreen()),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60.0, color: Colors.blue),
              SizedBox(height: 10.0),
              Text(title, style: TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
