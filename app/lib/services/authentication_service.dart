import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../screens/login_screen.dart';
import '../screens/authenticated/search_screen.dart';

class AuthenticationService extends ApiService{
  Future<void> register(BuildContext context, User user) async {
    await handleRequest(
      context: context,
      request: () => http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      ),
      onSuccess: () {
        ToastHelper.showSuccess(context, "Inscription réussie !");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
    );
  }

  Future<void> login(BuildContext context, String email, String password) async {
    final Map<String, dynamic> data = {
      'email_address': email,
      'password': password,
    };

    await handleRequest(
      context: context,
      request: () => http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ),
      onSuccess: () {
        ToastHelper.showSuccess(context, "Connecté avec succès");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
      },
    );
  }
}