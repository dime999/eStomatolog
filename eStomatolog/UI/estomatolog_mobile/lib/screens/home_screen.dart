import 'package:estomatolog_mobile/models/Ordinacija/ordinacija_pacijent.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/screens/ordinacija_details_screen.dart';
import 'package:estomatolog_mobile/widgets/clinic_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final int korisnikId;
  const HomeScreen({super.key, required this.korisnikId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<OrdinacijaPacijent> ordinacije = [];

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent = await pacijentProvider.getByKorisnikId(widget.korisnikId);
    return pacijent;
  }

  Future<List<OrdinacijaPacijent>> fetchOrdinacije(
      BuildContext context, String searchQuery) async {
    var ordinacijaProvider =
        Provider.of<PacijentOrdinacijaProvider>(context, listen: false);
    var pacijent = await fetchPacijent(context);
    var fetchedOrdinacije =
        await ordinacijaProvider.getByPacijentId(pacijent.id);
    var filteredOrdinacije = fetchedOrdinacije.result.where((ordinacija) {
      var naziv = ordinacija.ordinacijaNaziv.toLowerCase() ?? '';

      return naziv.contains(searchQuery.toLowerCase());
    }).toList();
    return filteredOrdinacije;
  }

  ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    _fetchOrdinacijeData();
  }

  Future<void> _fetchOrdinacijeData() async {
    var filteredOrdinacije = await fetchOrdinacije(context, "");
    setState(() {
      ordinacije = filteredOrdinacije;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pretraži",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ordinacije.length,
                  itemBuilder: (context, index) {
                    var ordinacija = ordinacije[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrdinacijaDetailScreen(
                              ordinacijaId: ordinacija.ordinacijaId,
                            ),
                          ),
                        );
                      },
                      child: ClinicListItem(
                        title: ordinacija.ordinacijaNaziv,
                        address: ordinacija.ordinacijaAdresa,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
