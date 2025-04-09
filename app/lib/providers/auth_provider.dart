import 'dart:ffi';

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = true;
  bool get isAuthenticated => _isAuthenticated;

  String _jwtToken = '';
  String get jwtToken => _jwtToken;

  int _userID = 0;
  int get userID => _userID;

  void login(String token, int authUserID) {
    _isAuthenticated = true;
    _jwtToken = token;
    _userID = authUserID;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _jwtToken = '';
    _userID = 0;
    notifyListeners();
  }
}
