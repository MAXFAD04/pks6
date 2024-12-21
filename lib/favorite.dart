import 'package:flutter/material.dart';
import 'package:my_first_app/repository.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = booksStore.where((book) => book.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index].title),
            subtitle: Text(favorites[index].author),
            trailing: Text('${favorites[index].price} р.'),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
