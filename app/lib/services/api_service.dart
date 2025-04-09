import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000';
  String baseErrorMessage = "Une erreur est survenue.";

  Future<void> handleRequest({
    required BuildContext context,
    required Future<http.Response> Function() request,
    required VoidCallback onSuccess,
  }) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
        return;
      }

      final Map<String, dynamic> errorResponse = jsonDecode(response.body);

      final message = errorResponse.containsKey("message") && errorResponse["message"].toString().isNotEmpty
          ? errorResponse["message"]
          : baseErrorMessage;

      throw Exception(message);
    } catch (e) {
      ToastHelper.showError(context, "$e");
    }
  }
}