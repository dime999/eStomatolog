import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/models/Rezervacija/rezervacija.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/providers/rezervacija_provider.dart';
import 'package:estomatolog_admin/widgets/list_rezervacije.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class RezervacijeHistorijaScreen extends StatefulWidget {
  final int pacijentId;
  final int ordinacijaId;
  const RezervacijeHistorijaScreen(
      {super.key, required this.pacijentId, required this.ordinacijaId});
  @override
  // ignore: library_private_types_in_public_api
  _RezervacijeHistorijaScreenState createState() =>
      _RezervacijeHistorijaScreenState();
}

class _RezervacijeHistorijaScreenState
    extends State<RezervacijeHistorijaScreen> {
  Future<List<Rezervacija>> fetchRezervacije(
      BuildContext context, String searchQuery) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    Pacijent pacijent =
        await pacijentProvider.getByKorisnikId(widget.pacijentId);
    var rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    var fetchedRezervacije = await rezervacijaProvider.getByPacijent(
        widget.ordinacijaId, pacijent.id);

    var filteredRezervacije = fetchedRezervacije.result.where((rezervacija) {
      var ime = rezervacija.doktorIme?.toLowerCase() ?? '';

      return ime.contains(searchQuery.toLowerCase());
    }).toList();
    filteredRezervacije.sort((a, b) => b.datum.compareTo(a.datum));
    return filteredRezervacije;
  }

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    return await pacijentProvider.getByKorisnikId(widget.pacijentId);
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();
  late RezervacijaProvider _rezervacijaProvider;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  bool isPast(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    _rezervacijaProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historija rezervacija'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListRezervacijeScreen<Rezervacija>(
            fetchData: (context) => fetchRezervacije(context, searchQuery),
            getFormattedDate: (rezervacija) =>
                rezervacija.datum.day.toString() +
                "." +
                rezervacija.datum.month.toString() +
                "." +
                rezervacija.datum.year.toString(),
            getDoctorName: (rezervacija) =>
                rezervacija.doktorIme.toString() +
                " " +
                rezervacija.doktorPrezime.toString(),
            getPacijentIme: (rezervacija) =>
                rezervacija.pacijentIme.toString() +
                " " +
                rezervacija.pacijentPrezime.toString(),
            isPastReservation: (rezervacija) =>
                isPast(rezervacija.datum.toString()),
            onDeletePressed: (rezervacija) async {
              try {
                await _rezervacijaProvider.delete(rezervacija.rezervacijaId);

                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Brisanje rezervacije'),
                      content: Text(
                          'Rezervacija je uspešno izbrisana iz historije!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              fetchRezervacije(context, searchQuery);
                            });
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } catch (e) {
                print("Greška prilikom dodavanja: $e");
                Navigator.of(context).pop();
              }
            },
            searchController: searchController,
          );
        },
      ),
    );
  }
}
