import 'package:flutter/material.dart';

class CustomListPregledKarticaScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final String Function(T) getImagePath;
  final void Function(T) onDeletePressed;
  final void Function()? onAddPressed;
  final void Function(T) onCardSelected;
  final TextEditingController searchController;

  const CustomListPregledKarticaScreen({
    Key? key,
    required this.fetchData,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImagePath,
    required this.onDeletePressed,
    required this.onCardSelected,
    required this.onAddPressed,
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
              hintText: 'Pretraži...',
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
                    child: Text('Greška pri dohvatanju podataka'));
              } else {
                var items = snapshot.data!;
                var canAddCard = items.length < 3;

                return ListView.builder(
                  itemCount: canAddCard ? items.length + 1 : items.length,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      var item = items[index];
                      return GestureDetector(
                          onTap: () => onCardSelected(item),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: ListTile(
                              leading: Image.asset(getImagePath(item)),
                              title: Text(getTitle(item)),
                              subtitle: Text(getSubtitle(item)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => onDeletePressed(item),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    } else {
                      return ListTile(
                        title: Text('Dodajte novu karticu'),
                        leading: Icon(Icons.add_circle_outline),
                        onTap: canAddCard ? onAddPressed : null,
                      );
                    }
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
