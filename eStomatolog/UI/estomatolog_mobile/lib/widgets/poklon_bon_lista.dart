import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon.dart';
import 'package:flutter/material.dart';

class GenericListBonoviScreen extends StatelessWidget {
  final Future<List<PoklonBon>> Function(BuildContext) fetchData;
  final TextEditingController searchController;

  const GenericListBonoviScreen({
    Key? key,
    required this.fetchData,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Pretraži po imenu korisnika...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<PoklonBon>>(
            future: fetchData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return const Center(
                  child: Text('Greška pri dohvatanju podataka'),
                );
              } else {
                var bonovi = snapshot.data!;

                return ListView.builder(
                  itemCount: bonovi.length,
                  itemBuilder: (context, index) {
                    var bon = bonovi[index];

                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: bon.iznosPlacanja == 30
                                ? Image.asset(
                                    'assets/images/bon1.png',
                                    width: 130,
                                    height: 130,
                                  )
                                : bon.iznosPlacanja == 50
                                    ? Image.asset(
                                        'assets/images/bon2.png',
                                        width: 130,
                                        height: 130,
                                      )
                                    : bon.iznosPlacanja == 100
                                        ? Image.asset(
                                            'assets/images/bon3.png',
                                            width: 130,
                                            height: 130,
                                          )
                                        : null,
                            subtitle: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Ime korisnika: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: bon.imePrezimeKorisnikaKojiKoristi,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Status plaćanja: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: bon.placeno
                                        ? 'Plaćeno'
                                        : 'NIJE PLAĆENO',
                                    style: TextStyle(
                                      color: bon.placeno
                                          ? Colors.green
                                          : Colors.red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Status iskorištenosti:  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: bon.iskoristeno
                                      ? 'ISKORIŠTENO'
                                      : 'Nije iskorišteno',
                                  style: TextStyle(
                                    color: bon.iskoristeno
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
