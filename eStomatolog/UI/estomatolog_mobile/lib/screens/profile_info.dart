import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/custome_profile_list_tile_model.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/screens/edit_profile.dart';
import 'package:estomatolog_mobile/screens/historija%20rezervacija.dart';
import 'package:estomatolog_mobile/screens/korisnik_kartice.dart';
import 'package:estomatolog_mobile/screens/korisnik_poklon_bonovi.dart';
import 'package:estomatolog_mobile/screens/login_screen.dart';
import 'package:estomatolog_mobile/screens/nalazi_lista.dart';
import 'package:estomatolog_mobile/screens/preporuceni_doktori_screen.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Colors.white,
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Korisničko ime: ${Authorization.korisnickoIme}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        customListTile(
                            "Kartice", false, FontAwesomeIcons.creditCard,
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => KarticeScreen(),
                            ),
                          );
                        }),
                        customListTile(
                          "Edit profila",
                          false,
                          FontAwesomeIcons.pen,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditUserScreen(
                                  korisnikId: Authorization.korisnikId,
                                ),
                              ),
                            ).then((value) {
                              setState(() {
                                fetchPacijent(context);
                              });
                            });
                          },
                        ),
                        customListTile(
                          "Historija rezervacija",
                          false,
                          FontAwesomeIcons.clockRotateLeft,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RezervacijeHistorijaScreen(
                                  pacijentId: pacijent.id,
                                ),
                              ),
                            );
                          },
                        ),
                        customListTile(
                          "Nalazi",
                          false,
                          FontAwesomeIcons.bookMedical,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NalaziScreen(
                                  pacijentId: pacijent.id,
                                ),
                              ),
                            );
                          },
                        ),
                        customListTile(
                          "Poklon bon",
                          false,
                          FontAwesomeIcons.gift,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KorinsikPoklonBon(
                                  pacijentId: pacijent.id,
                                ),
                              ),
                            );
                          },
                        ),
                        customListTile(
                          "Preporuceni doktori",
                          false,
                          FontAwesomeIcons.userDoctor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PreporuceniDoktoriScreen(
                                  pacijentId: pacijent.id,
                                ),
                              ),
                            );
                          },
                        ),
                        customListTile(
                          "Odjavi se",
                          true,
                          FontAwesomeIcons.locationDot,
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget customListTile(String title, bool isLogOut, IconData leadingIcon,
      {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // zaobljeni rubovi
          side: BorderSide(
            color: isLogOut == true
                ? Colors.red
                : Colors.black, // crna boja granice
            width: 0.3, // širina granice
          ),
        ),
        leading: Icon(
          leadingIcon, // ikona ispred teksta
          color: isLogOut == false ? Colors.black : Colors.red, // boja ikone
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        trailing:
            const Icon(Icons.arrow_forward), // ikonica na kraju sa strelicom
        onTap: onTap,
      ),
    );
  }
}
