import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotsale/data/service.dart';
import 'package:hotsale/model/user_model.dart';
import 'package:hotsale/pages/detail.dart';
import 'package:hotsale/storage/local_storage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          
          seedColor: const Color(0xFFb5b7af),
        
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.light,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final ApiService _apiService = Get.put(ApiService());
  final LocalStorageService _localStorageService =
      Get.put(LocalStorageService());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Користувачі'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: _apiService.getUsers(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return _buildUsersFromLocalStorage(); // Отримати користувачів з локального сховища в разі помилки або відсутності з'єднання
          } else {
            final users = snapshot.data;
            return ListView.builder(
              itemCount: users?.length,
              itemBuilder: (context, index) {
                final user = users?[index];
                return GestureDetector(
                  onTap: () => Get.to(DetailPage(user: user)),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user?.avatar ?? ''),
                      ),
                      title: Text(user?.name ?? ''),
                      subtitle: Text(user?.email ?? ''),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildUsersFromLocalStorage() {
    return FutureBuilder<List<UserModel>?>(
      future: _localStorageService.getUsersLocally(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Помилка: Не вдалося завантажити користувачів.'),
          );
        } else {
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return GestureDetector(
                onTap: () => Get.to(DetailPage(user: user)),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
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
