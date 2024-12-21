import 'package:flutter/material.dart';
import 'package:my_first_app/bookinfo.dart';
import 'package:my_first_app/booklist.dart';
import 'package:my_first_app/favorite.dart'; // Импортируйте FavoritesPage
import 'package:my_first_app/profile.dart'; // Импортируйте ProfilePage
import 'package:my_first_app/cart.dart'; // Импортируйте CartPage
import 'package:my_first_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Книжный магазин',
      theme: DarkTheme,
      routes: {
        '/': (context) => BooksList(title: 'Книжный магазин'),
        '/info': (context) => BookInfo(title: 'Информация о книге'),
        '/favorites': (context) => const FavoritesPage(), 
        '/profile': (context) => const ProfilePage(), 
        '/cart': (context) => const CartPage(), // Добавлено
      },
    );
  }
}
