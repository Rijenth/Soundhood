import '../models/user_model.dart';

/// Remote data source interface for User.
abstract class UserRemoteDataSource {
  Future<UserModel> fetchUser(String id);
  Future<void> createUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(String id);
}
