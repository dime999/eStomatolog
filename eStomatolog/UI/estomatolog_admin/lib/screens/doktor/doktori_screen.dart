import 'package:estomatolog_admin/screens/doktor/edit_doktor_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/providers/doktor_provider.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/lista.dart';
import 'package:provider/provider.dart';

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
                title: Text("Potvrda"),
                content:
                    Text("Da li ste sigurni da želite izbrisati korisnika?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await _korisniciProvider.delete(doktor.korisnikId);
                        var updatedDoctors = await fetchDoctors(context);
                        setState(() {
                          doktori = updatedDoctors;
                        });
                        Navigator.pop(context); // Zatvori dialog
                      } on Exception catch (e) {
                        String errorMessage =
                            "Nije moguće izbrisati odabranog doktora!";
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
      ),
    );
  }
}
