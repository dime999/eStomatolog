import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/models/Ocjene/ocjene.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor.dart';

class OcjeneScreen extends StatelessWidget {
  final int doktorId;

  const OcjeneScreen({Key? key, required this.doktorId}) : super(key: key);

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
        centerTitle: true,
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
              return const Text(
                'Sve ocjene',
                style: TextStyle(fontSize: 16),
              );
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
                          const Text(
                            'Ocjena: ',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            ocjena.ocjena.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          RatingBar.builder(
                            initialRating: ocjena.ocjena.toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                          ),
                          const SizedBox(width: 8.0),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Komentar: ${ocjena.opis}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      trailing: Text(
                        DateFormat('dd.MM.yyyy').format(ocjena.datum),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
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
