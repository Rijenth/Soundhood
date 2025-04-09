import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Use case for updating a user.
class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(User user) => repository.updateUser(user);
}
