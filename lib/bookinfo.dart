// bookinfo.dart
import 'package:flutter/material.dart';
import 'package:my_first_app/repository.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({super.key, required this.title});
  final String title;

  @override
  State<BookInfo> createState() => _BookInfoState();
}

class _BookInfoState extends State<BookInfo> {
  BookItem? book;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    super.didChangeDependencies();
    assert(args != null && args is int, 'Error: arguments must be int');
    int index = args as int;
    book = booksStore[index];
  }

  void _deleteBook() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Подтверждение удаления'),
          content: Text('Вы уверены, что хотите удалить "${book?.title}"?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  booksStore.remove(book);
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Возврат на предыдущий экран
              },
              child: Text('Удалить'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite() {
    setState(() {
      book?.isFavorite = !(book?.isFavorite ?? false);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(book!.isFavorite
            ? 'Книга добавлена в избранное'
            : 'Книга удалена из избранного'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(book?.isFavorite == true ? Icons.favorite : Icons.favorite_border),
            color: book?.isFavorite == true ? Colors.red : Colors.grey,
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteBook,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/img/${book?.img}',
              width: 200,
              height: 200,
              scale: .5,
            ),
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Text(book?.author ?? '', style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(book?.title ?? '', style: theme.textTheme.labelLarge, textAlign: TextAlign.center),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(book?.description ?? '', style: theme.textTheme.labelSmall, textAlign: TextAlign.left),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Арт: ${book?.code.toString() ?? ''}', style: theme.textTheme.labelSmall),
                Text('${book?.price.toString() ?? ''} р.', style: theme.textTheme.labelLarge),
              ],
            ),
            SizedBox(height: 20),
            TextButton.icon(
              label: Text('В корзину', style: theme.textTheme.bodyMedium),
              onPressed: () {
                cartStore.add(book!);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${book?.title} добавлена в корзину')),
                );
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
