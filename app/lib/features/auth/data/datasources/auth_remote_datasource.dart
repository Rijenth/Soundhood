import '../models/auth_model.dart';

/// Abstract contract for remote authentication.
abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<AuthModel> register(String email, String password);
  Future<void> logout();
  Future<bool> checkAuthStatus();
}
