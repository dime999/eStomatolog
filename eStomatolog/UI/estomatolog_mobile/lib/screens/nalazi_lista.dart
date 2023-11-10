import 'package:estomatolog_mobile/models/Nalaz/nalaz.dart';
import 'package:estomatolog_mobile/providers/nalaz_provider.dart';
import 'package:estomatolog_mobile/widgets/lista_nalaza.dart';
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

  Future<List<Nalaz>> fetchNalazi(
      BuildContext context, String searchQuery) async {
    var nalazProvider = Provider.of<NalazProvider>(context, listen: false);
    var fetchedNalzi = await nalazProvider.getByPacijentId(widget.pacijentId);

    var filteredNalzi = fetchedNalzi.result.where((nalaz) {
      var ime = nalaz.doktorIme?.toLowerCase() ?? '';

      return ime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredNalzi;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();
  late NalazProvider _nalazProvider;

  bool isPast(String datum) {
    var dateTime = DateTime.parse(datum);
    return dateTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    _nalazProvider = Provider.of<NalazProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moji nalazi'),
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
                    nalaz.datum!.year.toString() ??
                'N/A',
            getDoctorName: (nalaz) =>
                nalaz.doktorIme.toString() +
                    " " +
                    nalaz.doktorPrezime.toString() ??
                'N/A',
            getOpis: (nalaz) => nalaz.opis,
            searchController: searchController,
          );
        },
      ),
    );
  }
}
