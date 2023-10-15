import 'package:estomatolog_admin/screens/ordinacija/Nalazi/nalazi_lista.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pacijenti/pacijenti_ordinacija_lista.dart';
import 'package:estomatolog_admin/screens/ordinacija/ordinacije_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/utils/util.dart';

class PacijentOrdinacijaInfoScreen extends StatelessWidget {
  final int ordinacijaId;
  final int pacijentId;
  PacijentOrdinacijaInfoScreen(
      {required this.ordinacijaId, required this.pacijentId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izbornik detalja o pacijentu'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: Text(
                    'Prijavljeni doktor: ${Authorization.korisnickoIme}',
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
              icon: Icons.medical_information,
              title: 'Nalazi',
              ordinacijaId: ordinacijaId,
              pacijentId: pacijentId),
          CardItem(
              icon: Icons.note,
              title: 'Rezervacije',
              ordinacijaId: ordinacijaId,
              pacijentId: pacijentId),
          CardItem(
              icon: Icons.people,
              title: 'Informacije o pacijentu',
              ordinacijaId: ordinacijaId,
              pacijentId: pacijentId),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int ordinacijaId;
  final int pacijentId;

  CardItem(
      {required this.icon,
      required this.title,
      required this.ordinacijaId,
      required this.pacijentId});

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
            if (icon == Icons.medical_information && title == 'Nalazi') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NalaziScreen(pacijentId: pacijentId)),
              );
            } else if (icon == Icons.people && title == 'Rezervacije') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PacijentOrdinacijaScreen(ordinacijaId: ordinacijaId)),
              );
            } else if (icon == Icons.people &&
                title == 'Informacije o pacijentu') {
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
