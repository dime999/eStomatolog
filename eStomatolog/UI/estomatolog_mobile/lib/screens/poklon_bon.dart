import 'package:estomatolog_mobile/models/PoklonBon/poklon_bonovi_lista.dart';
import 'package:estomatolog_mobile/screens/poklon_bon_details.dart';
import 'package:estomatolog_mobile/widgets/poklon_bonovi_list_item.dart';
import 'package:flutter/material.dart';

class PoklonBonScreen extends StatefulWidget {
  @override
  _PoklonBonScreenState createState() => _PoklonBonScreenState();
}

class _PoklonBonScreenState extends State<PoklonBonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("Poklon bonovi"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text(
                  "Odaberite poklon bon za voljenu osobu,\nklikom na odabrani bon dobit ćete uvid u sve dodatne informacije.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
              ),
            ),
            SizedBox(height: 8),
            Icon(Icons.arrow_drop_down, size: 32, color: Colors.black),
            SizedBox(height: 16),
            Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bonovi.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PoklonBonInfoScreen(
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: PoklonBonoviListItem(
                          naziv: bonovi[index].naziv,
                          cijena: bonovi[index].cijena.toString() + " KM",
                          imageUrl: bonovi[index].imageUrl),
                    );
                  },
                ),
              ],
            ),
          ]),
        )));
  }
}
