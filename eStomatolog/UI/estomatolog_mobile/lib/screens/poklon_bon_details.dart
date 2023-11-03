import 'package:estomatolog_mobile/models/PoklonBon/poklon_bon_usluge.dart';
import 'package:estomatolog_mobile/models/PoklonBon/poklon_bonovi_lista.dart';
import 'package:flutter/material.dart';

class PoklonBonInfoScreen extends StatefulWidget {
  final int index;

  const PoklonBonInfoScreen({required this.index, Key? key}) : super(key: key);

  @override
  _PoklonBonInfoScreenState createState() => _PoklonBonInfoScreenState();
}

class _PoklonBonInfoScreenState extends State<PoklonBonInfoScreen> {
  TextEditingController imeController = TextEditingController();
  TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController datumRodjenjaController = TextEditingController();
  TextEditingController opisController = TextEditingController();

  double ocjenaKorisnika = 0;
  bool placeno = false;
  late int slikaIndex;
  late String valueSlike;
  late int giftCardPrice;

  @override
  void initState() {
    super.initState();
    slikaIndex = widget.index + 1;
    valueSlike = slikaIndex.toString();
    giftCardPrice = int.parse(bonovi[widget.index].cijena);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Poklon bon info'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage("assets/images/bon_banner${valueSlike}.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormField(
                                'Odabrani poklon bon:',
                                (bonovi[widget.index].naziv) +
                                    " " +
                                    valueSlike),
                            const SizedBox(height: 12.0),
                            _buildFormField('Cijena poklon bona:',
                                (bonovi[widget.index].cijena) + "KM"),
                            const SizedBox(height: 16.0),
                            Text(
                              'Usluge koje se mogu dobiti uz ovaj poklon bon:',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 220, 219, 219),
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: List.generate(
                                  bonoviUsluge.length,
                                  (index) {
                                    int servicePrice =
                                        bonoviUsluge[index].cijena;
                                    Color color = servicePrice <= giftCardPrice
                                        ? Colors.green
                                        : Colors.red;
                                    IconData icon =
                                        servicePrice <= giftCardPrice
                                            ? Icons.check
                                            : Icons.close;
                                    Color iconColor = Colors.white;

                                    return Container(
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            bonoviUsluge[index].naziv +
                                                "  / " +
                                                bonoviUsluge[index]
                                                    .cijena
                                                    .toString() +
                                                "KM",
                                            style: TextStyle(color: color),
                                          ),
                                          Icon(
                                            icon,
                                            color: iconColor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Container(
                              height: 1.0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.0),
                            Center(
                              child: Text(
                                'Odaberite način plaćanja',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.credit_card,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )));
  }

  Widget _buildFormField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 22.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
