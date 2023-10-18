import 'package:estomatolog_admin/models/Doktor/doktor.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/models/Rezervacija/rezervacija.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/providers/rezervacija_provider.dart';
import 'package:estomatolog_admin/screens/pacijent/add_pacijent_screen.dart';
import 'package:estomatolog_admin/screens/pacijent/edit_pacijent_screen.dart';
import 'package:flutter/material.dart';
import 'package:estomatolog_admin/providers/korisnici_provider.dart';
import 'package:estomatolog_admin/widgets/lista.dart';
import 'package:provider/provider.dart';

class RezervacijaScreen extends StatefulWidget {
  final int ordinacijaId;
  RezervacijaScreen({required this.ordinacijaId});
  @override
  _RezervacijaScreenState createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  List<Rezervacija> rezervacije = [];
  List<Pacijent> pacijenti = [];
  List<Doktor> doktori = [];

  Future<List<Rezervacija>> fetchRezervacije(BuildContext context) async {
    var rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    var fetchedRezervacije = await rezervacijaProvider.get(widget.ordinacijaId);
    return fetchedRezervacije.result;
  }

  late RezervacijaProvider _rezervacijaProvider;

  @override
  Widget build(BuildContext context) {
    _rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rezervacije'),
      ),
      body: GenericListScreen<Rezervacija>(
        fetchData: (context) => fetchRezervacije(context),
        getTitle: (rezervacija) => rezervacija.email ?? 'N/A',
        getSubtitle: (rezervacija) => rezervacija.datum.toString() ?? 'N/A',
        icon: Icons.person,
        onEditPressed: (pacijent) {
          print("Rezervacija");
        },
        onDeletePressed: (rezervacija) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Potvrda"),
                content:
                    Text("Da li ste sigurni da želite izbrisati rezervaciju?"),
                actions: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await _rezervacijaProvider
                            .delete(rezervacija.rezervacijaId);
                        var updatedRezervacije =
                            await fetchRezervacije(context);
                        setState(() {
                          rezervacije = updatedRezervacije;
                        });
                        Navigator.pop(context); // Zatvori dialog
                      } on Exception catch (e) {
                        String errorMessage =
                            "Nije moguće izbrisati odabranu rezervaciju!";
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
