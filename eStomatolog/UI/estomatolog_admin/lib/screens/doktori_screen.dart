import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_admin/models/doktor.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Doktor> doktori = [];

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
        title: Text('Doktori'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<DoktorProvider>(
              builder: (context, doktorProvider, child) {
                return FutureBuilder<List<Doktor>>(
                  future: fetchDoctors(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Greška pri dohvatanju podataka'));
                    } else {
                      var doktori = snapshot.data!;
                      return ListView.builder(
                        itemCount: doktori.length,
                        itemBuilder: (context, index) {
                          var doktor = doktori[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Icon(Icons.person), // Ikona doktora
                                title: Text(doktor.ime ?? 'N/A'),
                                subtitle: Text(doktor.prezime ?? 'N/A'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        // Otvorite ekran za uređivanje sa Navigator.push() metodom
                                        // Primer:
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => EditDoctorScreen(doctor: doktor),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () async {
                                        try {
                                          await _korisniciProvider
                                              .delete(doktor.korisnikId);
                                          var updatedDoctors =
                                              await fetchDoctors(context);
                                          // Postavite novu listu koristeći setState
                                          setState(() {
                                            doktori = updatedDoctors;
                                          });
                                        } on Exception catch (e) {
                                          String errorMessage =
                                              "Nije moguce izbrisati odabranog doktora!";
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Greška"),
                                                content: Text(errorMessage),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
