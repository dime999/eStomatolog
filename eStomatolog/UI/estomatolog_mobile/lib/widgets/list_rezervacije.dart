import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenericListRezervacijeScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getFormattedDate;
  final String Function(T) getDoctorName;
  final bool Function(T) isPastReservation;
  final void Function(T) onDeletePressed;
  final TextEditingController searchController;

  const GenericListRezervacijeScreen({
    Key? key,
    required this.fetchData,
    required this.getFormattedDate,
    required this.getDoctorName,
    required this.isPastReservation,
    required this.onDeletePressed,
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
              hintText: 'Pretraži po imenu doktora...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<T>>(
            future: fetchData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Greška pri dohvatanju podataka'),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Nemate historije rezervacija'),
                );
              } else {
                var items = snapshot.data!;
                var filteredList = items.where((item) {
                  var date = getFormattedDate(item);
                  var doctorName = getDoctorName(item).toLowerCase();
                  var searchQuery = searchController.text.toLowerCase();
                  return date.contains(searchQuery) ||
                      doctorName.contains(searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var item = filteredList[index];
                    var date = getFormattedDate(item);
                    var pastReservation = isPastReservation(item);
                    Color bojaKontejnera = pastReservation
                        ? Colors.red.shade400
                        : Colors.green.shade400;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: bojaKontejnera,
                          border: Border.all(color: Colors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            FontAwesomeIcons.calendar,
                            color: Colors.black,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Datum rezervacije:',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Doktor:',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                getDoctorName(item),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                onPressed: () => onDeletePressed(item),
                              ),
                            ],
                          ),
                        ),
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
