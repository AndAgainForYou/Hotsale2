import 'dart:convert';
import 'package:hotsale/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String key = 'users_key';

  Future<List<UserModel>> getUsersLocally() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  if (jsonString != null) {
    final jsonData = json.decode(jsonString);
    return List<UserModel>.from(jsonData.map((user) => UserModel.fromJson(user)));
  } else {
    return []; // Повертаємо порожній список, якщо дані відсутні
  }
}

  Future<void> saveUsersLocally(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = users.map((user) => user.toJson()).toList();
    final jsonString = json.encode(jsonData);
    await prefs.setString(key, jsonString);
  }
}