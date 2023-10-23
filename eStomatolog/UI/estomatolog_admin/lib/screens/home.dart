import 'package:estomatolog_admin/screens/doktor/doktori_screen.dart';
import 'package:estomatolog_admin/screens/ordinacija/ordinacije_screen.dart';
import 'package:estomatolog_admin/screens/pacijent/pacijenti_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/utils/util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Početna Stranica'),
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
        children: const [
          CardItem(icon: Icons.people, title: 'Pacijenti'),
          CardItem(icon: Icons.medical_services, title: 'Doktori'),
          CardItem(icon: Icons.local_hospital, title: 'Ordinacije'),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const CardItem({super.key, required this.icon, required this.title});

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
                MaterialPageRoute(builder: (context) => DoctorsScreen()),
              );
            } else if (icon == Icons.people && title == 'Pacijenti') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PacijentScreen()),
              );
            } else if (icon == Icons.local_hospital && title == 'Ordinacije') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrdinacijaScreen()),
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
