import '../repositories/auth_repository.dart';

/// Use case for logging out the user.
class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<void> call() => repository.logout();
}
