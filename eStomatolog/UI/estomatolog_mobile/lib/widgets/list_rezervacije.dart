import 'package:flutter/material.dart';

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
                print(snapshot.error);
                return const Center(
                  child: Text('Greška pri dohvatanju podataka'),
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
                    return Container(
                      child: ListTile(
                        subtitle: Text('Datum: $date'),
                        title: Text('Doktor: ${getDoctorName(item)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (pastReservation)
                              Text(
                                "Neaktivno",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                            if (!pastReservation)
                              Text(
                                "Aktivno",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => onDeletePressed(item),
                            ),
                          ],
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
