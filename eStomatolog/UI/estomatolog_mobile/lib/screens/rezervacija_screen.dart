import 'package:estomatolog_mobile/models/Termin/termin.dart';
import 'package:estomatolog_mobile/providers/termin_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RezervacijaScreen extends StatefulWidget {
  final int korisnikId;
  const RezervacijaScreen({super.key, required this.korisnikId});

  @override
  _RezervacijaScreenState createState() => _RezervacijaScreenState();
}

class _RezervacijaScreenState extends State<RezervacijaScreen> {
  DateTime? _selectedDate;
  List<Termin> _termini = [];

  @override
  void initState() {
    super.initState();
    _loadTermini();
  }

  Future<void> _loadTermini() async {
    var termini = await fetchTermini(context);
    setState(() {
      _termini = termini;
    });
  }

  Future<List<Termin>> fetchTermini(BuildContext context) async {
    print("Uslo");
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
        // Ovdje možete poslati odabrani datum na API za provjeru slobodnih termina
        // Poziv API-ja možete izvršiti unutar ove metode ili pozivom odvojene funkcije.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rezervacije")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Izaberite datum na koji želite rezervisati pregled:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate != null
                  ? 'Datum: ${_selectedDate!.day}.${_selectedDate!.month}.${_selectedDate!.year}'
                  : 'Izaberi Datum'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: _termini.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Ovdje implementirajte akciju koja se dešava kada korisnik klikne na termin
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          DateFormat.Hm().format(_termini[index].vrijeme),
                          style: TextStyle(fontSize: 16),
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
