import './credentials.dart';

/// Represents an authenticated session with token and credentials.
class Session {
  final Credentials credentials;
  final String token;

  Session({
    required this.credentials,
    required this.token,
  });
}
