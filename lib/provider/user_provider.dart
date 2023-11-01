import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:post_api/models/user_model.dart';
import 'package:post_api/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final service = UserService();
  bool isLoading = false;
  List<User> _users = [];
  List<User> get users => _users;

  getUsers() async {
    isLoading = true;
    notifyListeners();
    final res = await service.getAll();
    _users = res;
    log("e : ${_users.length}");
    isLoading = false;
    notifyListeners();
  }
}
