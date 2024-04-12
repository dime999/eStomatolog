import 'dart:math';

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.065,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black12, width: 1),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: const Icon(
                      //     Icons.menu,
                      //   ),
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dobrodošli nazad",
                            style: TextStyle(
                              fontFamily: 'SF Pro',
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.blue[700],
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${Authorization.korisnickoIme}',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.3), // Boja sjene
                                spreadRadius: 2, // Proširenje sjene
                                blurRadius: 5, // Zamućenje sjene
                                offset: Offset(0, 3), // Pomak sjene
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.search,
                  //         color: Colors.blue[200],
                  //         size: 28,
                  //       ),
                  //       SizedBox(
                  //         width: width * 0.02,
                  //       ),
                  //       Expanded(
                  //         child: TextFormField(
                  //           decoration: const InputDecoration.collapsed(
                  //             hintText: "Pretraži ordinaciju",
                  //             hintStyle: TextStyle(color: Colors.black26),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ordinacije.length,
                    itemBuilder: (context, index) {
                      var ordinacija = ordinacije[index];

                      return Column(
                        children: [
                          InkWell(
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
                              image: 'assets/images/klinika${index + 1}.jpg',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
