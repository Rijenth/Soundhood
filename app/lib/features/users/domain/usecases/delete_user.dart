import '../repositories/user_repository.dart';

/// Use case for deleting a user.
class DeleteUser {
  final UserRepository repository;

  DeleteUser(this.repository);

  Future<void> call(String id) => repository.deleteUser(id);
}
