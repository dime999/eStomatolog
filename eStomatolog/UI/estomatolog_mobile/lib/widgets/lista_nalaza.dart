import 'package:flutter/material.dart';

class GenericListNalazScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getFormattedDate;
  final String Function(T) getDoctorName;
  final String Function(T) getOpis;
  final TextEditingController searchController;

  const GenericListNalazScreen({
    Key? key,
    required this.fetchData,
    required this.getFormattedDate,
    required this.getDoctorName,
    required this.getOpis,
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
              } else if (snapshot.data?.length == 0) {
                return const Center(
                  child: Text('Nemate historiju nalaza'),
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

                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Image(
                              image: AssetImage('assets/images/nalaz.jpg'),
                              width: 50,
                              height: 50,
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Datum: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$date',
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
                                    text: 'Doktor: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '${getDoctorName(item)}',
                                    style: TextStyle(
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
                                  text: 'Nalaz:  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                                TextSpan(
                                  text: getOpis(item),
                                  style: TextStyle(
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
