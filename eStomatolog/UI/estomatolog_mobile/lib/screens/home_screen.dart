import 'package:estomatolog_mobile/models/Ordinacija/ordinacija_pacijent.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/providers/pacijent_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/screens/ordinacija_details_screen.dart';
import 'package:estomatolog_mobile/screens/profile_info.dart';
import 'package:estomatolog_mobile/utils/util.dart';
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
  late Pacijent pacijentData;

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
    pacijentData = pacijent;

    var fetchedOrdinacije =
        await ordinacijaProvider.getByPacijentId(pacijent.id);
    var filteredOrdinacije = fetchedOrdinacije.result;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        child: CircleAvatar(
                          radius: 45.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38.0,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Pozdrav ${Authorization.korisnickoIme}',
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFEF476F),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Text(
                                'Vaš profil',
                                style: TextStyle(
                                  fontFamily: 'SF Pro',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
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
