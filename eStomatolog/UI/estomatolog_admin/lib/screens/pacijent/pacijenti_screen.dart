import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/screens/pacijent/add_pacijent_screen.dart';
import 'package:estomatolog_admin/screens/pacijent/edit_pacijent_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/lista.dart';
import 'package:provider/provider.dart';

class PacijentScreen extends StatefulWidget {
  @override
  _PacijentScreenState createState() => _PacijentScreenState();
}

class _PacijentScreenState extends State<PacijentScreen> {
  TextEditingController searchController = TextEditingController();
  List<Pacijent> pacijenti = [];
  Future<List<Pacijent>> fetchPacijenti(
      BuildContext context, String searchQuery) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedPacijenti = await pacijentProvider.get();
    var filteredPacijenti = fetchedPacijenti.result.where((pacijent) {
      var ime = pacijent.ime?.toLowerCase() ?? '';
      var prezime = pacijent.prezime?.toLowerCase() ?? '';
      return ime.contains(searchQuery.toLowerCase()) ||
          prezime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredPacijenti;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacijenti'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListScreen<Pacijent>(
            fetchData: (context) => fetchPacijenti(context, searchQuery),
            getTitle: (pacijent) => pacijent.ime ?? 'N/A',
            getSubtitle: (pacijent) => pacijent.prezime ?? 'N/A',
            icon: Icons.person,
            onEditPressed: (pacijent) {
              int korisnikId = pacijent.korisnikId;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditPacijentScreen(korisnikId: korisnikId),
                ),
              );
            },
            onDeletePressed: (pacijent) async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Potvrda"),
                    content: Text(
                        "Da li ste sigurni da želite izbrisati korisnika?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          try {
                            await _korisniciProvider
                                .delete(pacijent.korisnikId);
                            var updatedPacijenti =
                                await fetchPacijenti(context, searchQuery);
                            setState(() {
                              pacijenti = updatedPacijenti;
                            });
                            Navigator.pop(context); // Zatvori dialog
                          } on Exception catch (e) {
                            String errorMessage =
                                "Nije moguće izbrisati odabranog pacijenta!";
                            // Prikaži grešku ako brisanje nije uspelo
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Greška"),
                                  content: Text(errorMessage),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text("Da"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(
                            context), // Zatvori dialog ako korisnik odabere "Ne"
                        child: Text("Ne"),
                      ),
                    ],
                  );
                },
              );
            },
            searchController: searchController,
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
