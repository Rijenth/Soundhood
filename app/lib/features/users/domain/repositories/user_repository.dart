import '../entities/user.dart';

/// Abstract repository contract for User.
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
