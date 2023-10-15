import 'package:estomatolog_admin/models/Nalaz/nalaz.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/providers/nalaz_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NalaziScreen extends StatelessWidget {
  final int pacijentId;

  NalaziScreen({required this.pacijentId});

  Future<Pacijent> fetchPacijent(BuildContext context, int id) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getByKorisnikId(id);
    print(pacijent.ime);
    return pacijent;
  }

  Future<List<Nalaz>> fetchNalazi(BuildContext context) async {
    Pacijent pacijent = await fetchPacijent(context, pacijentId) as Pacijent;
    print(pacijent);
    var nalaziProvider = Provider.of<NalazProvider>(context, listen: false);
    var fetchedNalazi = await nalaziProvider.getByPacijentId(pacijent.id);
    return fetchedNalazi.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Nalaza'),
      ),
      body: FutureBuilder<List<Nalaz>>(
        future: fetchNalazi(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Greška pri dohvatu nalaza.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nema dostupnih nalaza.'));
          } else {
            List<Nalaz> nalazi = snapshot.data!;
            return ListView.builder(
              itemCount: nalazi.length,
              itemBuilder: (context, index) {
                Nalaz nalaz = nalazi[index];
                return ListTile(
                  title: Text('Doktor: ${nalaz.doktorIme}'),
                  subtitle: Text('Opis: ${nalaz.opis}'),
                  trailing: Text('Datum: ${nalaz.datum.toString()}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
