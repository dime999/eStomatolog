import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/pacijent/add_pacijent_screen.dart';
import 'package:estomatolog_admin/widgets/lista_pregled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';

class OrdinacijaScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OrdinacijaScreenState createState() => _OrdinacijaScreenState();
}

class _OrdinacijaScreenState extends State<OrdinacijaScreen> {
  List<Ordinacija> ordinacije = [];
  Future<List<Ordinacija>> fetchOrdinacije(BuildContext context) async {
    var ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var fetchedOrdinacije = await ordinacijaProvider.get();
    return fetchedOrdinacije.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordinacije'),
      ),
      body: GenericListPregledScreen<Ordinacija>(
        fetchData: (context) => fetchOrdinacije(context),
        getTitle: (ordinacija) => ordinacija.naziv ?? 'N/A',
        getSubtitle: (ordinacija) => ordinacija.adresa ?? 'N/A',
        icon: Icons.local_hospital_rounded,
        onEditPressed: (ordinacija) {
          int? ordinacijaId = ordinacija.ordinacijaId;

          print(ordinacijaId);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPacijentScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
