import 'package:estomatolog_admin/providers/ordinacija_provider.dart';
import 'package:estomatolog_admin/screens/ordinacija/home_ordinacija.dart';
import 'package:estomatolog_admin/widgets/lista_pregled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:estomatolog_admin/models/Ordinacija/ordinacija.dart';

class OrdinacijaScreen extends StatefulWidget {
  const OrdinacijaScreen({super.key});

  @override
  _OrdinacijaScreenState createState() => _OrdinacijaScreenState();
}

class _OrdinacijaScreenState extends State<OrdinacijaScreen> {
  TextEditingController searchController = TextEditingController();
  List<Ordinacija> ordinacije = [];

  Future<List<Ordinacija>> fetchOrdinacije(
      BuildContext context, String searchQuery) async {
    var ordinacijaProvider =
        Provider.of<OrdinacijaProvider>(context, listen: false);
    var fetchedOrdinacije = await ordinacijaProvider.get();
    var filteredOrdinacije = fetchedOrdinacije.result.where((ordinacija) {
      var naziv = ordinacija.naziv.toLowerCase() ?? '';

      return naziv.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredOrdinacije;
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
        title: const Text('Lista ordinacija'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: searchQueryNotifier,
        builder: (context, searchQuery, child) {
          return GenericListPregledScreen<Ordinacija>(
            fetchData: (context) => fetchOrdinacije(context, searchQuery),
            getTitle: (ordinacija) => ordinacija.naziv ?? 'N/A',
            getSubtitle: (ordinacija) => ordinacija.adresa ?? 'N/A',
            imagePath: 'assets/images/ordinacija.png',
            onEditPressed: (ordinacija) {
              int ordinacijaId = ordinacija.ordinacijaId;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdinacijaHomeScreen(
                    ordinacijaId: ordinacijaId,
                  ),
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
