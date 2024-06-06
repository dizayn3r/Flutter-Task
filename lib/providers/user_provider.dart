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
}
