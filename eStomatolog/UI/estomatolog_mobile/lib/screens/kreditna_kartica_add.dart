import 'package:estomatolog_mobile/models/Korisnik/korisnik.dart';
import 'package:estomatolog_mobile/models/KorisnikKartica/korisnik_kartica_insert.dart';
import 'package:estomatolog_mobile/providers/korisnik_kartica_provider.dart';
import 'package:estomatolog_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class CreditCard extends StatefulWidget {
  final Korisnik korinik;
  const CreditCard({super.key, required this.korinik});

  @override
  State<StatefulWidget> createState() {
    return CreditCardView();
  }
}

class CreditCardView extends State<CreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = " ";
  String cvvCode = '';
  bool isCvvFocused = false;
  String? odabranaVrstaKartice;
  OutlineInputBorder? border;
  late Korisnik korisnik;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cardHolderName = "${widget.korinik.ime} ${widget.korinik.prezime}";
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    super.initState();
  }

  late KorisnikKarticaProvider _korisnikKarticaProvider;

  @override
  Widget build(BuildContext context) {
    _korisnikKarticaProvider =
        Provider.of<KorisnikKarticaProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kreditna kartica',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 5,
            ),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              bankName: '',
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: true,
              cardBgColor: Colors.blueGrey.shade700,
              isSwipeGestureEnabled: true,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              customCardTypeIcons: <CustomCardTypeIcon>[
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images.png',
                    height: 48,
                    width: 48,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CreditCardForm(
                      formKey: formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: cardNumber,
                      cvvCode: cvvCode,
                      isHolderNameVisible: false,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName: cardHolderName,
                      expiryDate: expiryDate,
                      themeColor: Colors.blue,
                      textColor: Colors.black,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Broj kartice',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: border,
                        enabledBorder: border,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: border,
                        enabledBorder: border,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        labelText: 'Datum isteka',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: border,
                        enabledBorder: border,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: border,
                        enabledBorder: border,
                        labelText: 'Card Holder',
                      ),
                      onCreditCardModelChange: onCreditCardModel,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 362,
                        child: DropdownButton<String>(
                          value: odabranaVrstaKartice,
                          onChanged: (String? newValue) {
                            setState(() {
                              odabranaVrstaKartice = newValue;
                            });
                          },
                          items: <String>['Visa', 'Mastercard']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text('Odaberite vrstu kartice'),
                          isExpanded: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            try {
                              KorisnikKarticaInsert kartica =
                                  KorisnikKarticaInsert(
                                      Authorization.korisnikId,
                                      cardNumber,
                                      odabranaVrstaKartice,
                                      expiryDate,
                                      cvvCode);
                              _korisnikKarticaProvider.novaKartica(kartica);
                              _showValidDialog(context);
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Row(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 10),
                                        Text('Dodavanje kartice'),
                                      ],
                                    ),
                                    content: const Text(
                                        'Dodavanje karticec nije uspjelo!'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              Navigator.of(context).pop();
                            }

                            print('valid!');
                          } else {
                            print('invalid!');
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Dodaj karticu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showValidDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text('Dodavanje kartice'),
            ],
          ),
          content: Text('Uspješno ste dodali novu karticu!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void onCreditCardModel(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
