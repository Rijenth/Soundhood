import '../entities/session.dart';
import '../repositories/auth_repository.dart';

/// Use case for registering a new user and returning a session with token.
class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Session> call(String email, String password) =>
      repository.register(email, password);
}
