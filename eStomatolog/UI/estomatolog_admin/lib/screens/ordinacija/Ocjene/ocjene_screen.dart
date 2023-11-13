import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Ocjene/ocjene.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/ocjene_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OcjeneScreen extends StatelessWidget {
  final int doktorId;

  OcjeneScreen({Key? key, required this.doktorId}) : super(key: key);

  Future<Doktor> fetchDoktor(BuildContext context, int id) async {
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var doktor = await doktorProvider.getById(id);
    return doktor;
  }

  Future<List<Ocjene>> fetchOcjene(BuildContext context) async {
    var ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
    var fetchOcjene = await ocjeneProvider.get(doktorId);
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
              return Text(
                  'Lista ocjena za doktora:  ${doktor.ime} ${doktor.prezime}');
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
                return Column(
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/images/avatar.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      title: Row(
                        children: [
                          Text(
                            'Ocjena: ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ocjena.ocjena.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          RatingBar.builder(
                            initialRating: ocjena.ocjena.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                          ),
                          const SizedBox(width: 10.0),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Komentar: ${ocjena.opis}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: Text(
                        'Datum: ${DateFormat('dd.MM.yyyy').format(ocjena.datum)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
