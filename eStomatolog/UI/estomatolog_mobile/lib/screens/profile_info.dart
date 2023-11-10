import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/custome_profile_list_tile_model.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/screens/edit_profile.dart';
import 'package:estomatolog_mobile/screens/historija%20rezervacija.dart';
import 'package:estomatolog_mobile/screens/korisnik_kartice.dart';
import 'package:estomatolog_mobile/screens/korisnik_poklon_bonovi.dart';
import 'package:estomatolog_mobile/screens/nalazi_lista.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Pacijent? pacijent;
  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var pacijent =
        await pacijentProvider.getByKorisnikId(Authorization.korisnikId);
    return pacijent;
  }

  @override
  void initState() {
    super.initState();
    _fetchPacijentData();
  }

  Future<void> _fetchPacijentData() async {
    var pacijentInfo = await fetchPacijent(context);
    setState(() {
      pacijent = pacijentInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text("PROFIL"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Column(
              children: [
                FutureBuilder<Pacijent>(
                  future: fetchPacijent(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Greška prilikom dohvata pacijenta.');
                    } else if (!snapshot.hasData) {
                      return const Text('Nema dostupnih informacija.');
                    } else {
                      Pacijent pacijent = snapshot.data!;
                      return Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${pacijent.ime}" + " " + "${pacijent.prezime}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Korisničko ime: ${Authorization.korisnickoIme}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ...List.generate(
                            customListTiles.length,
                            ((index) {
                              final tile = customListTiles[index];
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Card(
                                    elevation: 4,
                                    shadowColor: Colors.black12,
                                    child: ListTile(
                                      leading: Container(
                                        child: Icon(
                                          tile.icon,
                                          color: Colors.white,
                                        ),
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: tile.isLogOut
                                              ? Colors.red.withOpacity(0.8)
                                              : Colors.blue.withOpacity(0.8),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      title: Text(
                                        tile.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () {
                                        switch (index) {
                                          case 3:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => KarticeScreen(),
                                              ),
                                            );
                                            break;
                                          case 0:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditUserScreen(
                                                  korisnikId:
                                                      Authorization.korisnikId,
                                                ),
                                              ),
                                            );
                                          case 1:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    RezervacijeHistorijaScreen(
                                                  pacijentId: pacijent.id,
                                                ),
                                              ),
                                            );
                                          case 2:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => NalaziScreen(
                                                  pacijentId: pacijent.id,
                                                ),
                                              ),
                                            );
                                          case 4:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    KorinsikPoklonBon(
                                                  pacijentId: pacijent.id,
                                                ),
                                              ),
                                            );

                                          default:
                                        }
                                      },
                                    ),
                                  ));
                            }),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ));
  }
}
