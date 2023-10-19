import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/home_ordinacija.dart';
import 'package:estomatolog_admin/widgets/lista_pregled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';

class OrdinacijaScreen extends StatefulWidget {
  @override
  _OrdinacijaScreenState createState() => _OrdinacijaScreenState();
}

class _OrdinacijaScreenState extends State<OrdinacijaScreen> {
  TextEditingController searchController = TextEditingController();
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
          int ordinacijaId = ordinacija.ordinacijaId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrdinacijaHomeScreen(ordinacijaId: ordinacijaId),
            ),
          );
        },
        searchController: searchController,
      ),
    );
  }
}
