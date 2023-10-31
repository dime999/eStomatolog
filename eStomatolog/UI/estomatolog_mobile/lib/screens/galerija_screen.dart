import 'package:estomatolog_mobile/models/Ordinacija/ordinacija.dart';
import 'package:estomatolog_mobile/providers/slika_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ordinacija_provider.dart';

class GalerijaScreen extends StatefulWidget {
  final int ordinacijaId;
  const GalerijaScreen({super.key, required this.ordinacijaId});

  @override
  _GalerijaScreenState createState() => _GalerijaScreenState();
}

class _GalerijaScreenState extends State<GalerijaScreen> {
  int currentIndex = 0;
  late Ordinacija ordinacija;

  @override
  void initState() {
    super.initState();
    fetchOrdinacija(context);
  }

  Future<Ordinacija> fetchOrdinacija(BuildContext context) async {
    var ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    ordinacija = await ordinacijaProvider.getById(widget.ordinacijaId);
    setState(() {});
    return ordinacija;
  }

  Future<List<int>> fetchOrdinacijaSlike(BuildContext context) async {
    var ordinacijaSlikeProvider =
        Provider.of<SlikaProvider>(context, listen: false);
    var fetchedOrdinacije =
        await ordinacijaSlikeProvider.getSlikeIds(widget.ordinacijaId);
    return fetchedOrdinacije;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Galerija slika")),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                FutureBuilder<List<int>>(
                                  future: fetchOrdinacijaSlike(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          'Greška prilikom dohvata ID-ova slika.');
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Text(
                                          'Nema dostupnih ID-ova slika.');
                                    } else {
                                      List<int> slikeIds = snapshot.data!;

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Image.network(
                                              "https://10.0.2.2:7265/SlikaStream?slikaId=${slikeIds[currentIndex]}",
                                              width: 400,
                                              height: 400,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex > 0) {
                                                    setState(() {
                                                      currentIndex--;
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                    'Prethodna slika'),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (currentIndex <
                                                      slikeIds.length - 1) {
                                                    setState(() {
                                                      currentIndex++;
                                                    });
                                                  }
                                                },
                                                child: const Text(
                                                    'Sljedeća slika'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]))));
  }
}
