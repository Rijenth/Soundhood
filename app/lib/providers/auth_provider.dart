import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = true;

  bool get isAuthenticated => _isAuthenticated;

  String _jwtToken = '';
  String get jwtToken => _jwtToken;

  void login(String token) {
    _isAuthenticated = true;
    _jwtToken = token;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
