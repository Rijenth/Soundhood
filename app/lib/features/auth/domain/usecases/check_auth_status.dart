import '../repositories/auth_repository.dart';

/// Use case to check if a user is authenticated.
class CheckAuthStatus {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  Future<bool> call() => repository.isAuthenticated();
}
