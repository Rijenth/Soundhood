import 'dart:convert';
import 'package:http/http.dart' as http;

/// Abstract contract for an HTTP API service.
abstract class ApiService {
  Future<Map<String, dynamic>> get(String url);
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body);
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body);
  Future<void> delete(String url);
}

/// Concrete implementation of ApiService using the http package.
class ApiServiceImpl implements ApiService {
  final String baseUrl;
  final http.Client httpClient;

  ApiServiceImpl({required this.baseUrl, http.Client? client})
      : httpClient = client ?? http.Client();

  /// Sends a GET request to the given [url] and returns the JSON-decoded response.
  @override
  Future<Map<String, dynamic>> get(String url) async {
    final response = await httpClient.get(Uri.parse('$baseUrl$url'));
    _handleErrors(response);
    return json.decode(response.body);
  }

  /// Sends a POST request with [body] to the given [url].
  @override
  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> body) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl$url'),
      headers: _headers,
      body: json.encode(body),
    );
    _handleErrors(response);
    return json.decode(response.body);
  }

  /// Sends a PUT request with [body] to update a resource at the given [url].
  @override
  Future<Map<String, dynamic>> put(String url, Map<String, dynamic> body) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl$url'),
      headers: _headers,
      body: json.encode(body),
    );
    _handleErrors(response);
    return json.decode(response.body);
  }

  /// Sends a PATCH request with [body] to partially update a resource at the given [url].
  @override
  Future<Map<String, dynamic>> patch(String url, Map<String, dynamic> body) async {
    final response = await httpClient.patch(
      Uri.parse('$baseUrl$url'),
      headers: _headers,
      body: json.encode(body),
    );
    _handleErrors(response);
    return json.decode(response.body);
  }

  /// Sends a DELETE request to the given [url].
  @override
  Future<void> delete(String url) async {
    final response = await httpClient.delete(Uri.parse('$baseUrl$url'));
    _handleErrors(response);
  }

  /// Common headers for API requests.
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Handles non-2xx HTTP responses by throwing an exception.
  void _handleErrors(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        statusCode: response.statusCode,
        message: response.body.isNotEmpty ? response.body : 'Unknown error',
      );
    }
  }
}

/// Exception thrown when an HTTP request fails.
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  @override
  String toString() => 'ApiException ($statusCode): $message';
}
