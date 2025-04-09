import '../entities/user_auth.dart';

/// Contract for authentication repository.
abstract class AuthRepository {
  Future<UserAuth> login(String email, String password);
  Future<UserAuth> register(String email, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
}
