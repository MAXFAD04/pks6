import 'package:flutter/material.dart';
import 'package:my_first_app/repository.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Метод для вычисления общей стоимости
  double _calculateTotalCost() {
    return cartStore.fold(0, (total, item) => total + item.price);
  }

  void _removeItem(int index) {
    setState(() {
      cartStore.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cartStore.isEmpty
          ? const Center(child: Text('Корзина пуста'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartStore.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cartStore[index].title),
                        subtitle: Text(cartStore[index].author),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _removeItem(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Общая стоимость: ${_calculateTotalCost()} р.',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}
