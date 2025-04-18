import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import '../screens/authenticated/home_screen.dart';

class AuthenticationService extends ApiService {
  Future<void> register(BuildContext context, User user) async {
    await handleRequest(
      context: context,
      request:
          () => http.post(
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

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final Map<String, dynamic> data = {
      'email_address': email,
      'password': password,
    };

    await handleRequest(
      context: context,
      request:
          () => http.post(
            Uri.parse('$baseUrl/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          ),
      onSuccess: (response) {
        final jwt = response['jwt'];
        final userID = response['user_id'];

        if (jwt is String && jwt.isNotEmpty && userID is int) {
          context.read<AuthProvider>().login(jwt, userID);

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

  Future<void> logout(
      BuildContext context
      ) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    final response = await http.post(
        Uri.parse('$baseUrl/auth/logout'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
    );
    if(response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  Future<Map<String, dynamic>?> me(BuildContext context) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    return await handleRequest(
      context: context,
      request:
          () => http.get(
            Uri.parse('$baseUrl/auth/me'),
            headers: {
              'Authorization': 'Bearer $jwt',
              'Content-Type': 'application/json',
            },
          ),
      onSuccess: (response) {
        if (response is Map<String, dynamic>) {
          final profile = response['profile'];

          if (profile != null) {
            return profile;
          }
        }

        return null;
      },
    );
  }
}
