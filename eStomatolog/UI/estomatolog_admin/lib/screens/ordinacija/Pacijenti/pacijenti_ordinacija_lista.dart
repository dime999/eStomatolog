import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent_ordinacija.dart';
import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/Pacijenti/pacijent_ordinacija_info.dart';
import 'package:estomatolog_admin/screens/pacijent/add_pacijent_screen.dart';
import 'package:estomatolog_admin/widgets/lista_pregled.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:provider/provider.dart';

class PacijentOrdinacijaScreen extends StatefulWidget {
  final int ordinacijaId;
  PacijentOrdinacijaScreen({required this.ordinacijaId});
  @override
  _PacijentOrdinacijaScreenState createState() =>
      _PacijentOrdinacijaScreenState();
}

class _PacijentOrdinacijaScreenState extends State<PacijentOrdinacijaScreen> {
  List<PacijentOrdinacija> pacijenti = [];
  Future<List<PacijentOrdinacija>> fetchPacijenti(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentOrdinacijaProvider>(context, listen: false);
    var fetchedPacijenti = await pacijentProvider.get(widget.ordinacijaId);
    return fetchedPacijenti.result;
  }

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var pacijentProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var ordinacija = await pacijentProvider.getById(widget.ordinacijaId);
    return ordinacija;
  }

  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Ordinacija>(
          future: fetchOrdinacija(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Lista nalaza - Učitavanje...');
            } else if (snapshot.hasError) {
              return Text('Greška pri dohvatu nalaza.');
            } else if (!snapshot.hasData) {
              return Text('Nema dostupnih podataka o pacijentu.');
            } else {
              Ordinacija ordinacija = snapshot.data!;
              return Text(
                  'Lista pacijenata iz ordinacije: - ${ordinacija.naziv} ${ordinacija.adresa} ');
            }
          },
        ),
      ),
      body: GenericListPregledScreen<PacijentOrdinacija>(
        fetchData: (context) => fetchPacijenti(context),
        getTitle: (pacijent) => pacijent.pacijentIme ?? 'N/A',
        getSubtitle: (pacijent) => pacijent.pacijentPrezime ?? 'N/A',
        icon: Icons.person,
        onEditPressed: (pacijent) {
          int korisnikId = pacijent.korisnikId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PacijentOrdinacijaInfoScreen(
                ordinacijaId: widget.ordinacijaId,
                pacijentId: korisnikId,
              ),
            ),
          );
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