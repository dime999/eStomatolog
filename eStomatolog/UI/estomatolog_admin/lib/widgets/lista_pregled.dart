import 'package:flutter/material.dart';

class GenericListPregledScreen<T> extends StatelessWidget {
  final Future<List<T>> Function(BuildContext) fetchData;
  final String Function(T) getTitle;
  final String Function(T) getSubtitle;
  final IconData icon;
  final void Function(T) onEditPressed;
  final TextEditingController searchController;

  const GenericListPregledScreen({super.key, 
    required this.fetchData,
    required this.getTitle,
    required this.getSubtitle,
    required this.icon,
    required this.onEditPressed,
    required this.searchController,
  });

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
                return const Center(child: Text('Greška pri dohvatanju podataka'));
              } else {
                var items = snapshot.data!;
                var filteredList = items.where((item) {
                  var title = getTitle(item).toLowerCase();
                  var subtitle = getSubtitle(item).toLowerCase();
                  var searchQuery = searchController.text.toLowerCase();
                  return title.contains(searchQuery) ||
                      subtitle.contains(searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var item = filteredList[index];
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
                              icon: const Icon(Icons.view_carousel),
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
          ),
        ),
      ],
    );
  }
}
