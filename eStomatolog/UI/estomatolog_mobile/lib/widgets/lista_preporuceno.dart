import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class GenericListPregledRecomenndedScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getDoctorName;
  final double Function(T) getRating;
  final void Function(T) onView;

  const GenericListPregledRecomenndedScreen({
    Key? key,
    required this.fetchData,
    required this.getDoctorName,
    required this.getRating,
    required this.onView,
  }) : super(key: key);

  Widget getRatingBar(double rating) {
    return Row(
      children: [
        Text('Ocjena: '),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 25.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
          ignoreGestures: true,
          tapOnlyMode: false,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Korisnici sličnih preferencija kao Vi preporučuju ove doktore',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Image(
                image: AssetImage('assets/images/recommended.png'),
                width: 50,
                height: 50,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
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

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    var doctorName = getDoctorName(item);
                    var rating = getRating(item);

                    return Column(children: [
                      ListTile(
                        leading: const Image(
                          image: AssetImage('assets/images/doctor_avatar.jpg'),
                          width: 50,
                          height: 50,
                        ),
                        title: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Doktor:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                ),
                              ),
                              TextSpan(
                                text: doctorName,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: getRatingBar(rating),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              image:
                                  AssetImage('assets/images/recommended1.png'),
                              width: 35,
                              height: 35,
                            ),
                            IconButton(
                              icon: const Icon(Icons.view_agenda),
                              onPressed: () => onView(item),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ]);
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
