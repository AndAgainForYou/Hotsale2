import 'dart:convert';
import 'package:hotsale/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<UserModel>> getUsers(int page) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final usersData = jsonData['data'];
      List<UserModel> users = List<UserModel>.from(usersData.map((user) => UserModel.fromJson(user)));
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}