import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService extends ApiService {
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
