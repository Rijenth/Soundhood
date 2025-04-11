import 'dart:convert';

import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000';
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
      final dynamic message = errorResponse['message'];
      final dynamic details = errorResponse['details'];

      throw {
        if (message != null) 'message': message,
        if (details != null) 'details': details,
      };
    } catch (e) {
      print("hello $e");
      if (e is String) {
        ToastHelper.showError(context, e);
        return null;
      }

      if (e is Map<String, dynamic>) {
        if (e.containsKey('details') && e['details'] is Map) {
          final details = e['details'] as Map<String, dynamic>;

          for (var entry in details.entries) {
            ToastHelper.showError(context, "${entry.key} : ${entry.value}");
          }

          return null;
        }
      }

      ToastHelper.showError(context, "Une erreur inconnue est survenue.");

      return null;
    }
  }
}
