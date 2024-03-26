import 'package:estomatolog_mobile/models/PoklonBon/poklon_bonovi_lista.dart';
import 'package:estomatolog_mobile/screens/poklon_bon_details.dart';
import 'package:estomatolog_mobile/widgets/poklon_bonovi_list_item.dart';
import 'package:flutter/material.dart';

class PoklonBonScreen extends StatefulWidget {
  final int ordinacijaId;
  const PoklonBonScreen({required this.ordinacijaId, Key? key})
      : super(key: key);
  @override
  _PoklonBonScreenState createState() => _PoklonBonScreenState();
}

class _PoklonBonScreenState extends State<PoklonBonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Poklon bonovi",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Odaberite poklon bon za voljenu osobu,\nklikom na odabrani bon dobit ćete uvid u sve dodatne informacije.",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.arrow_drop_down, size: 32, color: Colors.black),
              const SizedBox(height: 16),
              Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                                ordinacijaId: widget.ordinacijaId,
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
            ],
          ),
        ),
      ),
    );
  }
}
