import 'package:estomatolog_admin/screens/doktor/add_doktor_screen.dart';
import 'package:estomatolog_admin/screens/doktor/edit_doktor_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/lista.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class DoctorsScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Doktor> doktori = [];

  Future<List<Doktor>> fetchDoctors(
      BuildContext context, String searchQuery) async {
    var doktortProvider = Provider.of<DoktorProvider>(context, listen: false);
    var fetchedDoctors = await doktortProvider.get();
    var filteredDoktori = fetchedDoctors.result.where((doktor) {
      var ime = doktor.ime?.toLowerCase() ?? '';
      var prezime = doktor.prezime?.toLowerCase() ?? '';
      return ime.contains(searchQuery.toLowerCase()) ||
          prezime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredDoktori;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  late KorisniciProvider _korisniciProvider;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doktori'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListScreen<Doktor>(
            fetchData: (context) => fetchDoctors(context, searchQuery),
            getTitle: (doktor) => doktor.ime ?? 'N/A',
            getSubtitle: (doktor) => doktor.prezime ?? 'N/A',
            imagePath: 'assets/images/lista_doktor.png',
            onEditPressed: (doktor) {
              int korisnikId = doktor.korisnikId;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDoctorScreen(
                    korisnikId: korisnikId,
                    doktorId: doktor.id,
                  ),
                ),
              );
            },
            onDeletePressed: (doktor) async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Potvrda"),
                    content: const Text(
                        "Da li ste sigurni da želite izbrisati korisnika?"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          try {
                            await _korisniciProvider.delete(doktor.korisnikId);
                            var updatedDoktori =
                                await fetchDoctors(context, searchQuery);
                            setState(() {
                              doktori = updatedDoktori;
                            });
                            Navigator.pop(context);
                          } on Exception {
                            String errorMessage =
                                "Nije moguće izbrisati odabranog pacijenta!";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Greška"),
                                  content: Text(errorMessage),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Da"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Ne"),
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
              builder: (context) => const AddDoctorScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
