import '../entities/session.dart';

/// Contract for authentication repository using JWT-based sessions.
abstract class AuthRepository {
  /// Logs in the user and returns a session with token.
  Future<Session> login(String email, String password);

  /// Registers a new user and returns a session with token.
  Future<Session> register(String email, String password);

  /// Logs out the current user and clears the session/token.
  Future<void> logout();

  /// Checks if the current session is authenticated (token still valid).
  Future<bool> isAuthenticated();
}
