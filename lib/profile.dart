import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: "Имя");
  final TextEditingController _surnameController = TextEditingController(text: "Фамилия");
  final TextEditingController _emailController = TextEditingController(text: "email@example.com");

  // Переменная состояния для контроля режима редактирования
  bool _isEditing = false;

  void _updateProfile() {
    // Здесь можно добавить логику для обновления профиля
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Профиль обновлен')),
    );
    setState(() {
      _isEditing = false; // После обновления профиля выключаем режим редактирования
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
              enabled: _isEditing, // Делаем поле редактируемым только в режиме редактирования
            ),
            TextField(
              controller: _surnameController,
              decoration: const InputDecoration(labelText: 'Фамилия'),
              enabled: _isEditing, // Делаем поле редактируемым только в режиме редактирования
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              enabled: _isEditing, // Делаем поле редактируемым только в режиме редактирования
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isEditing) {
                  _updateProfile(); // Если в режиме редактирования, обновляем профиль
                } else {
                  setState(() {
                    _isEditing = true; // Включаем режим редактирования
                  });
                }
              },
              child: Text(_isEditing ? 'Сохранить изменения' : 'Изменить профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
