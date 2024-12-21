import 'package:flutter/material.dart';
import 'package:my_first_app/repository.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key, required this.title});
  final String title;

  @override
  State<BooksList> createState() => _BooksList();
}

class _BooksList extends State<BooksList> {
  final bookStore = booksStore;

  // Функция для удаления книги
  void _deleteBook(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить эту книгу?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Удалить'),
              onPressed: () {
                setState(() {
                  bookStore.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

void _addBook() {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imgController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить книгу'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Автор'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
              ),
              TextField(
                controller: imgController,
                decoration: const InputDecoration(labelText: 'Изображение (имя файла)'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Добавить'),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  authorController.text.isNotEmpty &&
                  priceController.text.isNotEmpty &&
                  imgController.text.isNotEmpty) {
                try {
                  final price = int.parse(priceController.text);
                  setState(() {
                    final newBook = BookItem(
                      code: DateTime.now().millisecondsSinceEpoch, // Генерация уникального кода
                      title: titleController.text,
                      author: authorController.text,
                      description: descriptionController.text,
                      price: price,
                      img: imgController.text,
                    );
                    bookStore.insert(0, newBook); // Добавление в начало списка
                  });
                  Navigator.of(context).pop();
                } catch (e) {
                  // Обработка ошибки
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ошибка: введите корректную цену.')),
                  );
                }
              } else {
                // Если одно из полей пустое
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ошибка: все поля должны быть заполнены.')),
                );
              }
            },
          ),
        ],
      );
    },
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
          icon: Icon(Icons.add),
          onPressed: _addBook,
        ),
      ],
    ),
    body: ListView.separated(
      itemCount: bookStore.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.white30),
      itemBuilder: (context, index) => ListTile(
        leading: Image.asset(
          'assets/img/${bookStore[index].img}',
          width: 50,
          height: 50,
        ),
        title: Text(bookStore[index].title, style: theme.textTheme.bodyMedium),
        subtitle: Text(bookStore[index].author, style: theme.textTheme.labelSmall),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${bookStore[index].price.toInt().toString()} р.', style: theme.textTheme.labelSmall),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteBook(index),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/info', arguments: index);
        },
      ),
    ),
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Книги'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина'), // Добавляем корзину
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
  ],
  currentIndex: 0, 
  selectedItemColor: Colors.white, 
  unselectedItemColor: Colors.grey[300], 
  backgroundColor: Colors.black26, 
  onTap: (index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/');
        break;
      case 1:
        Navigator.of(context).pushNamed('/favorites');
        break;
      case 2:
        Navigator.of(context).pushNamed('/cart'); 
        break;
      case 3:
        Navigator.of(context).pushNamed('/profile');
        break;
        }
      },
    ),
  );
}
}
