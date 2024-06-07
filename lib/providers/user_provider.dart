import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  /// Process Indicator
  bool _loading = false;

  bool get loading => _loading;

  /// User List
  List<User> _users = [];

  List<User> get users => _users;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setUsers(List<User> value) {
    _users = value;
  }

  /// Get Users
  getUsers() async {
    setLoading(true);
    http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    List<dynamic> temp = jsonDecode(response.body);
    List<User> modifiedList = [];
    for (var element in temp) {
      User user = User.fromJson(element);
      modifiedList.add(user);
    }
    setUsers(modifiedList);
    setLoading(false);
  }

  /// Create User
  Future<bool> createUser({required User user}) async {
    http.Response response = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  /// Update User
  Future<bool> updateUser({required User user}) async {
    http.Response response = await http.patch(
      Uri.parse("https://jsonplaceholder.typicode.com/users/${user.id}"),
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// Delete Users
  Future<bool> deleteUser(int userId) async {
    http.Response response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/users/$userId"));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
