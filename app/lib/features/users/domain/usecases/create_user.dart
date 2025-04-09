import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Use case for creating a new user.
class CreateUser {
  final UserRepository repository;

  CreateUser(this.repository);

  Future<void> call(User user) => repository.createUser(user);
}
