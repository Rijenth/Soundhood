import 'dart:convert';

import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:http/http.dart' as http;

class AuthenticationService extends ApiService{
  Future<Map<String, dynamic>> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}