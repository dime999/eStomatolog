import 'package:estomatolog_admin/models/Nalaz/nalaz.dart';
import 'package:estomatolog_admin/models/Pacijent/pacijent.dart';
import 'package:estomatolog_admin/providers/nalaz_provider.dart';
import 'package:estomatolog_admin/providers/pacijent_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/Nalazi/nalazi_insert.dart';
import 'package:estomatolog_admin/widgets/lista_nalaza.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NalaziScreen extends StatefulWidget {
  final int pacijentId;

  const NalaziScreen({super.key, required this.pacijentId});
  @override
  _NalaziScreenState createState() => _NalaziScreenState();
}

class _NalaziScreenState extends State<NalaziScreen> {
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  Future<Pacijent> fetchPacijent(BuildContext context, int id) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getByKorisnikId(id);
    return pacijent;
  }

  Future<List<Nalaz>> fetchNalazi(
      BuildContext context, String searchQuery) async {
    Pacijent pacijent = await fetchPacijent(context, widget.pacijentId);
    var nalazProvider = Provider.of<NalazProvider>(context, listen: false);
    var fetchedNalzi = await nalazProvider.getByPacijentId(pacijent.id);

    var filteredNalzi = fetchedNalzi.result.where((nalaz) {
      var ime = nalaz.doktorIme.toLowerCase();

      return ime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredNalzi;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();

  bool isPast(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nalazi pacijenta'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListNalazScreen<Nalaz>(
            fetchData: (context) => fetchNalazi(context, searchQuery),
            getFormattedDate: (nalaz) =>
                nalaz.datum!.day.toString() +
                "." +
                nalaz.datum!.month.toString() +
                "." +
                nalaz.datum!.year.toString(),
            getDoctorName: (nalaz) =>
                nalaz.doktorIme.toString() +
                " " +
                nalaz.doktorPrezime.toString(),
            getOpis: (nalaz) => nalaz.opis,
            searchController: searchController,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Dodajte logiku za navigaciju na stranicu za dodavanje nalaza
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DodajNalazScreen(
                      pacijentId: widget.pacijentId,
                    )), // Zamijenite DodajNalazScreen sa stvarnom klasom za dodavanje nalaza
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
