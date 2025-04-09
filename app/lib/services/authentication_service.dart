import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import '../screens/authenticated/home_screen.dart';

class AuthenticationService extends ApiService{
  Future<void> register(BuildContext context, User user) async {
    await handleRequest(
      context: context,
      request: () => http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      ),
      onSuccess: (response) {
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
      onSuccess: (response) {
        final jwt = response['jwt'];

        if (jwt is String && jwt.isNotEmpty) {
          context.read<AuthProvider>().login(jwt);

          ToastHelper.showSuccess(context, "Connexion réussie !");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );

          return;
        }

        ToastHelper.showError(context, "Jeton manquant ou invalide.");
      },
    );
  }

  Future<void> me(BuildContext context) async {
    await handleRequest(
      context: context,
      request: () => http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Authorization': 'Bearer',
          'Content-Type': 'application/json'
        },
      ),
      onSuccess: (response) {
        if (response is String) {
          ToastHelper.showSuccess(context, response);
        }
      },
    );
  }
}