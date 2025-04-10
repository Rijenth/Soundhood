import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://c316-2a0d-e487-44f-b395-29ef-996e-7663-dafb.ngrok-free.app';
  String baseErrorMessage = "Une erreur est survenue.";

  Future<dynamic> handleRequest({
    required BuildContext context,
    required Future<http.Response> Function() request,
    required Function(dynamic body) onSuccess,
  }) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        return onSuccess(responseBody);
      }

      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      final message = errorResponse['message'] ?? baseErrorMessage;
      throw Exception(message);
    } catch (e) {
      ToastHelper.showError(context, "$e");
      return null;
    }
  }
}
