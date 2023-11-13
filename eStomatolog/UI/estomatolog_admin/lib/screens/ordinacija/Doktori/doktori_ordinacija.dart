import 'package:estomatolog_admin/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_admin/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_admin/providers/ocjene_provider.dart';
import 'package:estomatolog_admin/screens/doktor/edit_doktor_screen.dart';
import 'package:estomatolog_admin/screens/ordinacija/Ocjene/ocjene_screen.dart';
import 'package:estomatolog_admin/widgets/lista_doktori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class DoctorsOrdinacijaScreen extends StatefulWidget {
  final int ordinacijaId;
  const DoctorsOrdinacijaScreen({super.key, required this.ordinacijaId});
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
    var fetchedDoctors =
        await doktorProvider.getByOrdinacijaId(widget.ordinacijaId);

    for (var doktor in fetchedDoctors.result) {
      var providerOcjene = Provider.of<OcjeneProvider>(context, listen: false);
      var fetchedOcjene = await providerOcjene.get(doktor.doktorId);

      doktor.ocjene
          .addAll(fetchedOcjene.result.map((ocjena) => ocjena.ocjena).toList());
    }

    var filteredDoktori = fetchedDoctors.result.where((doktor) {
      var ime = doktor.doktorIme?.toLowerCase() ?? '';
      var prezime = doktor.doktorPrezime?.toLowerCase() ?? '';
      return ime.contains(searchQuery.toLowerCase()) ||
          prezime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredDoktori;
  }

  double izracunajProsjecnuOcjenu(List<int> ocjene) {
    if (ocjene.isEmpty) {
      return 0.0;
    }
    double sumaOcjena =
        ocjene.map((ocjena) => ocjena.toDouble()).reduce((a, b) => a + b);
    double prosjek = sumaOcjena / ocjene.length;
    return prosjek;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doktori'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListPregledScreen<DoktorOrdinacija>(
            fetchData: (context) => fetchDoctors(context, searchQuery),
            getDoctorName: (doktor) =>
                doktor.doktorIme! + " " + doktor.doktorPrezime!,
            getRating: (doktor) => izracunajProsjecnuOcjenu(doktor.ocjene),
            onView: (doktor) {
              int korisnikId = doktor.korisnikId;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDoctorScreen(
                    korisnikId: korisnikId,
                    doktorId: doktor.doktorId,
                  ),
                ),
              );
            },
            onRatingView: (doktor) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OcjeneScreen(
                    doktorId: doktor.doktorId,
                  ),
                ),
              )
            },
            searchController: searchController,
          );
        },
      ),
    );
  }
}
