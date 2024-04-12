import 'package:animate_do/animate_do.dart';
import 'package:estomatolog_mobile/models/Doktor/doktor_ordinacija.dart';
import 'package:estomatolog_mobile/models/Pacijent/pacijent.dart';
import 'package:estomatolog_mobile/models/Rezervacija/rezervacija_insert.dart';
import 'package:estomatolog_mobile/models/Termin/termin.dart';
import 'package:estomatolog_mobile/models/Termin/termin_zauzeti.dart';
import 'package:estomatolog_mobile/providers/doktor_ordinacija_provider.dart';
import 'package:estomatolog_mobile/providers/pacijent_provider.dart';
import 'package:estomatolog_mobile/providers/rezervacija_provider.dart';
import 'package:estomatolog_mobile/providers/termin_provider.dart';
import 'package:estomatolog_mobile/screens/success_reservation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijaScreen extends StatefulWidget {
  final int korisnikId;
  final int ordinacijaId;
  const RezervacijaScreen(
      {super.key, required this.korisnikId, required this.ordinacijaId});

  @override
  // ignore: library_private_types_in_public_api
  _RezervacijaScreenState createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  DateTime? _selectedDate;
  List<Termin> _termini = [];
  List<TerminZauzeti> _zauzetiTermini = [];
  List<DoktorOrdinacija> doktori = [];
  late Pacijent pacijent;
  late bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _loadZauzetiTermini();
    _loadTermini();
    fetchPacijent(context);
    _loadDoctors();
  }

  void _refreshData() async {
    await _loadZauzetiTermini();
    await _loadTermini();
  }

  Future<void> _loadZauzetiTermini() async {
    var zauzetiTermini = await fetchZauzetiTermini(context, _selectedDate!);
    setState(() {
      _zauzetiTermini = zauzetiTermini;
    });
  }

  Future<void> _loadTermini() async {
    var termini = await fetchTermini(context);
    setState(() {
      _termini = termini;
    });
  }

  Future<List<DoktorOrdinacija>> fetchDoctors(
      BuildContext context, String searchQuery) async {
    var doktorProvider =
        Provider.of<DoktorOrdinacijaProvider>(context, listen: false);
    var fetchedDoctors =
        await doktorProvider.getByOrdinacijaId(widget.ordinacijaId);
    doktori = fetchedDoctors.result;

    return doktori;
  }

  void _loadDoctors() async {
    var doktori = await fetchDoctors(context, '');
    setState(() {
      selectedDoctorId =
          doktori.isNotEmpty ? doktori[0].doktorId.toString() : '';
      odabraniDoktor = int.tryParse(selectedDoctorId!);
    });
  }

  Future<Pacijent> fetchPacijent(BuildContext context) async {
    var pacijentProvider =
        Provider.of<PacijentProvider>(context, listen: false);
    var fetchedPacijent =
        await pacijentProvider.getByKorisnikId(widget.korisnikId);
    pacijent = fetchedPacijent;
    return pacijent;
  }

  Future<List<Termin>> fetchTermini(BuildContext context) async {
    var terminProvider = Provider.of<TerminProvider>(context, listen: false);
    var termini = await terminProvider.get();
    return termini.result;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      var zauzeti_termini = await fetchZauzetiTermini(context, _selectedDate!);
      setState(() {
        _zauzetiTermini = zauzeti_termini;
        _isVisible = true;
      });
    }
  }

  Future<List<TerminZauzeti>> fetchZauzetiTermini(
      BuildContext context, DateTime datum) async {
    var terminProvider =
        Provider.of<RezervacijaProvider>(context, listen: false);
    var termini = await terminProvider.getByDatum(widget.ordinacijaId, datum);
    return termini.result;
  }

  String? selectedDoctorId;
  final TextEditingController _emailContorller = TextEditingController();
  bool _isEmailValid = true;
  int? odabraniDoktor;
  late RezervacijaProvider _rezervacijaProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Rezervacija pregleda",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Izaberite datum na koji želite rezervisati pregled:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _selectDate(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _selectedDate != null
                        ? 'Datum: ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                        : 'Izaberi Datum',
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: _termini.length,
                itemBuilder: (context, index) {
                  bool isTerminZauzet = _zauzetiTermini.any((zauzetiTermin) =>
                      zauzetiTermin.terminId == _termini[index].terminId);
                  return GestureDetector(
                    onTap: () async {
                      if (!isTerminZauzet) {
                        var doktori = await fetchDoctors(context, '');

                        // ignore: use_build_context_synchronously
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            String selectedDoctorId = doktori.isNotEmpty
                                ? doktori[0].doktorId.toString()
                                : '';

                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Unesite email za potvrdu rezervacije:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 300,
                                        child: TextField(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Email za potvrdu rezervacije',
                                              prefixIcon:
                                                  const Icon(Icons.email),
                                              border:
                                                  const OutlineInputBorder(),
                                              errorText: _isEmailValid
                                                  ? null
                                                  : 'Unesite ispravnu e-mail adresu',
                                            ),
                                            controller: _emailContorller,
                                            onChanged: (email) {
                                              bool isValid = RegExp(
                                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                                  .hasMatch(email);
                                              setState(() {
                                                _isEmailValid = isValid;
                                              });
                                            }),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Izaberite doktora:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        width: 300,
                                        child: DropdownButtonFormField<String>(
                                          value: selectedDoctorId,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedDoctorId = newValue!;
                                              odabraniDoktor = int.tryParse(
                                                  selectedDoctorId);
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Izaberite doktora',
                                            prefixIcon: Icon(Icons.person),
                                            border: OutlineInputBorder(),
                                          ),
                                          items: doktori
                                              .map<DropdownMenuItem<String>>(
                                            (DoktorOrdinacija doktor) {
                                              return DropdownMenuItem<String>(
                                                value:
                                                    doktor.doktorId.toString(),
                                                child: Text(
                                                    '${doktor.doktorIme} ${doktor.doktorPrezime}'),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Vaša rezervacija će biti spremljena za datum ${DateFormat('dd.MM.yyyy').format(_selectedDate!)} u terminu ${DateFormat('HH:mm').format(_termini[index].vrijeme)}, ukoliko rezervacija bude uspješna bit ćete obaviješteni emailom.',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: const ButtonStyle(),
                                              onPressed: () async {
                                                _rezervacijaProvider = Provider
                                                    .of<RezervacijaProvider>(
                                                        context,
                                                        listen: false);
                                                RezervacijaInsert
                                                    rezervacijaInsert =
                                                    RezervacijaInsert(
                                                        _selectedDate!,
                                                        _emailContorller.text,
                                                        pacijent.id,
                                                        widget.ordinacijaId,
                                                        odabraniDoktor!,
                                                        _termini[index]
                                                            .terminId);

                                                try {
                                                  await _rezervacijaProvider
                                                      .insert(
                                                          rezervacijaInsert);
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.of(context).pop();
                                                  // ignore: use_build_context_synchronously
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Potvrda rezervacije'),
                                                        content: const Text(
                                                            'Rezervacija je uspešno potvrđena!'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      SuccessReservatioScreen(
                                                                    korisnikId:
                                                                        widget
                                                                            .korisnikId,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: const Text(
                                                                'OK'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } catch (e) {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text(
                                                  'Potvrdi rezervaciju'),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                    child: FadeInDown(
                      child: AnimatedOpacity(
                        opacity: _isVisible
                            ? 1.0
                            : 0.0, // Postavite opacity na 1.0 ako je element vidljiv, inače na 0.0
                        duration: const Duration(
                            milliseconds: 500), // Trajanje animacije
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isTerminZauzet ? Colors.red : Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: isTerminZauzet
                                ? Colors.red.withOpacity(0.1)
                                : Colors.green.withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isTerminZauzet
                                  ? const Icon(Icons.event_busy,
                                      color: Colors.red, size: 24)
                                  : const Icon(Icons.event_available,
                                      color: Colors.green, size: 24),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.Hm().format(_termini[index].vrijeme),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
