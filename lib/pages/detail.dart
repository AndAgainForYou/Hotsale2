import 'package:flutter/material.dart';
import 'package:hotsale/model/user_model.dart';

class DetailPage extends StatelessWidget {
  final UserModel? user;

  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Деталі користувача'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 46.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(user?.avatar ?? ''),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0, bottom: 5.0),
                  child: Text(
                    'ID: ${user?.id ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0, bottom: 5.0),
                  child: Text(
                    'Name: ${user?.name ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0, bottom: 5.0),
                  child: Text(
                    'Email: ${user?.email ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
