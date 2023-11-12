import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon.dart';
import 'package:estomatolog_mobile/providers/poklon_bon_provider.dart';
import 'package:estomatolog_mobile/widgets/poklon_bon_lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KorinsikPoklonBon extends StatefulWidget {
  final int pacijentId;

  const KorinsikPoklonBon({super.key, required this.pacijentId});
  @override
  _KorisnikPoklonBonScreenState createState() =>
      _KorisnikPoklonBonScreenState();
}

class _KorisnikPoklonBonScreenState extends State<KorinsikPoklonBon> {
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchQueryNotifier.value = searchController.text;
    });
  }

  Future<List<PoklonBon>> fetchPoklonBonovi(
      BuildContext context, String searchQuery) async {
    var poklonBonProvider =
        Provider.of<PoklonBonProvider>(context, listen: false);
    var fetchedBonovi =
        await poklonBonProvider.getByPacijentId(widget.pacijentId);

    var filteredBonovi = fetchedBonovi.result.where((bon) {
      var ime = bon.imePrezimeKorisnikaKojiKoristi.toLowerCase();

      return ime.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredBonovi;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moji poklon bonovi'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListBonoviScreen(
            fetchData: (context) => fetchPoklonBonovi(context, searchQuery),
            searchController: searchController,
          );
        },
      ),
    );
  }
}
