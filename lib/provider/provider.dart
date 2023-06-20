import 'package:amazon/model/user.dart';
import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {
  User _user = User(
      token: '',
      id: '',
      username: '',
      email: '',
      password: '',
      address: '',
      type: '');

  User get user => _user;
  void setUser(Map<String,dynamic> user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
