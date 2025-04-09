import '../entities/user_auth.dart';
import '../repositories/auth_repository.dart';

/// Use case for registering a new user.
class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<UserAuth> call(String email, String password) =>
      repository.register(email, password);
}
