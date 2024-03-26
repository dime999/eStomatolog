import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/KorisnikKartica/korisnik_kartica.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/providers/korisnik_kartica_provider.dart';
import 'package:estomatolog_mobile/screens/kreditna_kartica_add.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:estomatolog_mobile/widgets/lista_pregled_kartice.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class KarticeScreen extends StatefulWidget {
  const KarticeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _KarticeScreenState createState() => _KarticeScreenState();
}

class _KarticeScreenState extends State<KarticeScreen> {
  TextEditingController searchController = TextEditingController();
  List<KorisnikKartica> kartice = [];
  late Korisnik korisnik;

  Future<List<KorisnikKartica>> fetchKartice(
      BuildContext context, String searchQuery) async {
    var karticeProvider =
        Provider.of<KorisnikKarticaProvider>(context, listen: false);
    var fetchedKartice =
        await karticeProvider.getByKorisnikId(Authorization.korisnikId);
    kartice = fetchedKartice.result;
    var filteredKartice = fetchedKartice.result.where((kartica) {
      var naziv = kartica.vrstaKartica.toLowerCase();
      return naziv.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredKartice;
  }

  Future<Korisnik> fetchKorisnik(BuildContext context) async {
    var korisnikProvider =
        Provider.of<KorisniciProvider>(context, listen: false);
    var fetchedKorisnik =
        await korisnikProvider.getById(Authorization.korisnikId);
    korisnik = fetchedKorisnik;
    return korisnik;
  }

  String _getImagePath(KorisnikKartica kartica) {
    var vrstaKartice = kartica.vrstaKartica.toLowerCase();
    if (vrstaKartice.contains('visa')) {
      return 'assets/images/visa.png';
    } else if (vrstaKartice.contains('mastercard')) {
      return 'assets/images/mastercard_logo.png';
    } else {
      return 'assets/default_card_logo.png';
    }
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  late KorisnikKarticaProvider _korisnikKarticaProvider;

  @override
  void initState() {
    fetchKorisnik(context);
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    _korisnikKarticaProvider =
        Provider.of<KorisnikKarticaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Moje kreditne kartice',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<String>(
          valueListenable: searchQueryNotifier,
          builder: (context, searchQuery, child) {
            return CustomListPregledKarticaScreen<KorisnikKartica>(
              fetchData: (context) => fetchKartice(context, searchQuery),
              getTitle: (kartica) => kartica.vrstaKartica,
              getSubtitle: (kartica) => kartica.brojKartice,
              getImagePath: (kartica) => _getImagePath(kartica),
              onCardSelected: (kartica) => {},
              onAddPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreditCard(
                      korinik: korisnik,
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    fetchKartice(context, "");
                  });
                });
                ;
              },
              onDeletePressed: (kartica) {
                try {
                  _korisnikKarticaProvider.delete(kartica.id);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            Text('Potvrda brisanja'),
                          ],
                        ),
                        content: const Text('Kartica je uspješno izbrisana!'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              var updatedKartice = await fetchKartice(
                                  context, searchQueryNotifier.value);
                              setState(() {
                                kartice = updatedKartice;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Row(
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            Text('Potvrda brisanja'),
                          ],
                        ),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              searchController: searchController,
            );
          },
        ),
      ),
    );
  }
}
