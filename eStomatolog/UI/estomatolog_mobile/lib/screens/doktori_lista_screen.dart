import 'package:estomatolog_mobile/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_mobile/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/korisnici_provider.dart';
import 'package:estomatolog_mobile/screens/dokltor_info_rate.dart';
import 'package:estomatolog_mobile/widgets/lista_pregled.dart';
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
        title: const Text('Doktori'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListPregledScreen<DoktorOrdinacija>(
            fetchData: (context) => fetchDoctors(context, searchQuery),
            getTitle: (doktor) => doktor.doktorIme ?? 'N/A',
            getSubtitle: (doktor) => doktor.doktorPrezime ?? 'N/A',
            icon: Icons.medical_information,
            onEditPressed: (pacijent) {
              int korisnikId = pacijent.korisnikId;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DoktorInfoScreen(korisnikId: korisnikId),
                ),
              );
            },
            searchController: searchController,
          );
        },
      ),
    );
  }
}
