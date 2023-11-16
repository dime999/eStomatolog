import 'package:estomatolog_mobile/models/Doktor/doktor_recommended.dart';
import 'package:estomatolog_mobile/providers/doktor_provider.dart';
import 'package:estomatolog_mobile/providers/ocjene_provider.dart';
import 'package:estomatolog_mobile/screens/doktor_info_rate.dart';
import 'package:estomatolog_mobile/widgets/lista_preporuceno.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class PreporuceniDoktoriScreen extends StatefulWidget {
  final int pacijentId;
  const PreporuceniDoktoriScreen({super.key, required this.pacijentId});
  @override
  // ignore: library_private_types_in_public_api
  _PreporuceniDoktoriScreenState createState() =>
      _PreporuceniDoktoriScreenState();
}

class _PreporuceniDoktoriScreenState extends State<PreporuceniDoktoriScreen> {
  List<DoktorRecommended> doktori = [];

  Future<List<DoktorRecommended>> fetchDoctors(BuildContext context) async {
    var doktorProvider = Provider.of<DoktorProvider>(context, listen: false);
    var fetchedDoctors = await doktorProvider.getRecommended(widget.pacijentId);

    for (var doktor in fetchedDoctors.result) {
      var providerOcjene = Provider.of<OcjeneProvider>(context, listen: false);
      var fetchedOcjene = await providerOcjene.get(doktor.id);

      doktor.doktorOrdinacije
          .addAll(fetchedOcjene.result.map((ocjena) => ocjena.ocjena).toList());
    }

    var filteredDoktori = fetchedDoctors.result;
    return filteredDoktori;
  }

  double izracunajProsjecnuOcjenu(List<int> ocjene) {
    if (ocjene.isEmpty) {
      return 0.0;
    }
    double sumaOcjena =
        ocjene.map((ocjena) => ocjena.toDouble()).reduce((a, b) => a + b);
    double prosjek = sumaOcjena / ocjene.length;
    return prosjek;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Preporučeni doktori'),
          centerTitle: true,
        ),
        body: GenericListPregledRecomenndedScreen<DoktorRecommended>(
          fetchData: (context) => fetchDoctors(context),
          getDoctorName: (doktor) => doktor.ime! + " " + doktor.prezime!,
          getRating: (doktor) =>
              izracunajProsjecnuOcjenu(doktor.doktorOrdinacije),
          onView: (doktor) {
            int korisnikId = doktor.korisnikId;
            int doktorId = doktor.id;
            double ocjenaProsjek =
                izracunajProsjecnuOcjenu(doktor.doktorOrdinacije);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoktorInfoScreen(
                  korisnikId: korisnikId,
                  doktorId: doktorId,
                  ocjena: ocjenaProsjek,
                ),
              ),
            );
          },
        ));
  }
}
