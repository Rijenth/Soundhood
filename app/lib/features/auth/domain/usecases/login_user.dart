import '../entities/user_auth.dart';
import '../repositories/auth_repository.dart';

/// Use case for logging in the user.
class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<UserAuth> call(String email, String password) =>
      repository.login(email, password);
}
