import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Ocjene/ocjene.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/ocjene_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OcjeneScreen extends StatelessWidget {
  final int doktorId;

  OcjeneScreen({super.key, required this.doktorId});

  Future<Doktor> fetchDoktor(BuildContext context, int id) async {
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var doktor = await doktorProvider.getByKorisnikId(id);
    return doktor;
  }

  Future<List<Ocjene>> fetchOcjene(BuildContext context) async {
    Doktor doktor = await fetchDoktor(context, doktorId);
    var ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    var fetchOcjene = await ocjeneProvider.get(doktor.id);
    return fetchOcjene.result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Doktor>(
          future: fetchDoktor(context, doktorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Lista ocjena - Učitavanje...');
            } else if (snapshot.hasError) {
              return const Text('Greška pri dohvatu doktora.');
            } else if (!snapshot.hasData) {
              return const Text('Nema dostupnih podataka o doktoru.');
            } else {
              Doktor doktor = snapshot.data!;
              return Text('Lista ocjena - ${doktor.ime} ${doktor.prezime}');
            }
          },
        ),
      ),
      body: FutureBuilder<List<Ocjene>>(
        future: fetchOcjene(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Greška pri dohvatu ocjena.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nema dostupnih ocjena.'));
          } else {
            List<Ocjene> ocjene = snapshot.data!;
            return ListView.builder(
              itemCount: ocjene.length,
              itemBuilder: (context, index) {
                Ocjene ocjena = ocjene[index];
                return ListTile(
                  title: Text('Ocjena: ${ocjena.ocjena.toString()}'),
                  subtitle: Text('Opis: ${ocjena.opis}'),
                  trailing: Text('Datum: ${ocjena.datum.toString()}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
