import 'package:estomatolog_admin/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_admin/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/doktor/add_doktor_screen.dart';
import 'package:estomatolog_admin/screens/doktor/edit_doktor_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/lista.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class DoctorsOrdinacijaScreen extends StatefulWidget {
  final int ordinacijaId;
  DoctorsOrdinacijaScreen({required this.ordinacijaId});
  @override
  // ignore: library_private_types_in_public_api
  _DoctorsOrdinacijaScreenState createState() =>
      _DoctorsOrdinacijaScreenState();
}

class _DoctorsOrdinacijaScreenState extends State<DoctorsOrdinacijaScreen> {
  TextEditingController searchController = TextEditingController();
  List<DoktorOrdinacija> doktori = [];

  Future<List<DoktorOrdinacija>> fetchDoctors(
      BuildContext context, String searchQuery) async {
    var doktorProvider =
        Provider.of<DoktorOrdinacijaProvider>(context, listen: false);
    var fetchedDoctors = await doktorProvider.get(widget.ordinacijaId);
    var filteredDoktori = fetchedDoctors.result.where((doktor) {
      var ime = doktor.doktorIme?.toLowerCase() ?? '';
      var prezime = doktor.doktorPrezime?.toLowerCase() ?? '';
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
        title: Text('Doktori'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListScreen<DoktorOrdinacija>(
            fetchData: (context) => fetchDoctors(context, searchQuery),
            getTitle: (doktor) => doktor.doktorIme ?? 'N/A',
            getSubtitle: (doktor) => doktor.doktorPrezime ?? 'N/A',
            icon: Icons.person,
            onEditPressed: (pacijent) {
              int korisnikId = pacijent.korisnikId;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditDoctorScreen(korisnikId: korisnikId),
                ),
              );
            },
            onDeletePressed: (doktor) async {
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
                            await _korisniciProvider.delete(doktor.korisnikId);
                            var updatedDoktori =
                                await fetchDoctors(context, searchQuery);
                            setState(() {
                              doktori = updatedDoktori;
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
              builder: (context) => AddDoctorScreen(),
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
