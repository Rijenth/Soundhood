import 'dart:convert';
import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService extends ApiService {

  Future<List<User>> getAllUsers(BuildContext context) async {

    final jwtToken = Provider.of<AuthProvider>(context, listen: false).jwtToken;

    try {
      print('--- Envoi de la requête GET ---');
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> usersJson = jsonDecode(response.body);
        final users = usersJson.map((json) => User.fromJson(json)).toList();
        return users;
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? baseErrorMessage);
        return [];
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return [];
    }
  }

  Future<User?> getUserById(BuildContext context, String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? baseErrorMessage);
        return null;
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return null;
    }
  }

  Future<void> updateProfile(
      BuildContext context,
      Map<String, dynamic> profileData,
      ) async {
    final authProvider = context.read<AuthProvider>();
    final jwt = authProvider.jwtToken;
    final userId = authProvider.userID;

    if (jwt.isEmpty || userId == 0) {
      ToastHelper.showError(context, "Utilisateur non authentifié");
      return;
    }

    await handleRequest(
      context: context,
      request:
          () => http.patch(
        Uri.parse('$baseUrl/users/$userId/profile'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profileData),
      ),
      onSuccess: (response) {
        ToastHelper.showSuccess(context, "Profil mis à jour avec succès");
      },
    );
  }
}