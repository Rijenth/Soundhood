import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Use case for getting a single user.
class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<User> call(String id) => repository.getUser(id);
}
