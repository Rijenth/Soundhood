import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

/// Repository implementation for User using a remote data source.
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<User> getUser(String id) async {
    final model = await remote.fetchUser(id);
    return model.toEntity();
  }

  @override
  Future<void> createUser(User user) async {
    final model = UserModel.fromEntity(user);
    await remote.createUser(model);
  }

  @override
  Future<void> updateUser(User user) async {
    final model = UserModel.fromEntity(user);
    await remote.updateUser(model);
  }

  @override
  Future<void> deleteUser(String id) async {
    await remote.deleteUser(id);
  }
}
