import '../entities/session.dart';
import '../repositories/auth_repository.dart';

/// Use case for logging in the user and returning a session with token.
class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Session> call(String email, String password) =>
      repository.login(email, password);
}
