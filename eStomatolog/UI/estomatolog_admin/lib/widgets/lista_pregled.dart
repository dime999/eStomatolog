import 'package:flutter/material.dart';

class GenericListPregledScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final IconData icon;
  final void Function(T) onEditPressed;

  GenericListPregledScreen({
    required this.fetchData,
    required this.getTitle,
    required this.getSubtitle,
    required this.icon,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: fetchData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text('Greška pri dohvatanju podataka'));
        } else {
          var items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: ListTile(
                  leading: Icon(icon),
                  title: Text(getTitle(item)),
                  subtitle: Text(getSubtitle(item)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => onEditPressed(item),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
