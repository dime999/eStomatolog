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
  List<Doktor> doktori = [];

  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }

  Future<void> _loadDoctors() async {
    var fetchedDoctors = await fetchDoctors(context);
    print("Uslo");
    setState(() {
      doktori = fetchedDoctors;
    });
  }

  Future<List<Doktor>> fetchDoctors(BuildContext context) async {
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var fetchedDoctors = await doktorProvider.get();
    return fetchedDoctors.result;
  }

  late KorisniciProvider _korisniciProvider;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = Provider.of<KorisniciProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Doktori'),
      ),
      body: GenericListScreen<Doktor>(
        fetchData: (context) => fetchDoctors(context),
        getTitle: (doktor) => doktor.ime ?? 'N/A',
        getSubtitle: (doktor) => doktor.prezime ?? 'N/A',
        icon: Icons.person,
        onEditPressed: (doktor) {
          int korisnikId = doktor.korisnikId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditDoctorScreen(korisnikId: korisnikId),
            ),
          );
        },
        onDeletePressed: (doktor) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // ignore: prefer_const_constructors
                title: Text("Potvrda"),
                content:
                    // ignore: prefer_const_constructors
                    Text("Da li ste sigurni da želite izbrisati korisnika?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await _korisniciProvider.delete(doktor.korisnikId);
                        // ignore: use_build_context_synchronously
                        var updatedDoctors = await fetchDoctors(context);
                        setState(() {
                          doktori = updatedDoctors;
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context); // Zatvori dialog
                        // ignore: unused_catch_clause
                      } on Exception catch (e) {
                        String errorMessage =
                            "Nije moguće izbrisati odabranog doktora!";
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // ignore: prefer_const_constructors
                              title: Text("Greška"),
                              content: Text(errorMessage),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  // ignore: prefer_const_constructors
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    // ignore: prefer_const_constructors
                    child: Text("Da"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    // ignore: prefer_const_constructors
                    child: Text("Ne"),
                  ),
                ],
              );
            },
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
