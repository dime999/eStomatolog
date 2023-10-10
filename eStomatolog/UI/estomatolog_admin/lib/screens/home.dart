import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/master_screeen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Početna Stranica'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CardItem(icon: Icons.people, title: 'Pacijenti'),
          CardItem(icon: Icons.medical_services, title: 'Doktori'),
          CardItem(icon: Icons.local_hospital, title: 'Ordinacije'),
          CardItem(icon: Icons.event_note, title: 'Rezervacije'),
          CardItem(icon: Icons.rate_review, title: 'Recenzije'),
          CardItem(icon: Icons.report, title: 'Izvještaji'),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  CardItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          // Akcija koja će se izvršiti kada korisnik pritisne karticu
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0, color: Colors.blue),
            SizedBox(height: 10.0),
            Text(title, style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
