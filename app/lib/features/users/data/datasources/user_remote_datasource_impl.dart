import './user_remote_datasource.dart';
import '../../../../core/services/api_service.dart';
import '../models/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<UserModel> fetchUser(String id) async {
    final json = await api.get('/users/$id');
    return UserModel.fromJson(json);
  }

  @override
  Future<void> createUser(UserModel user) async {
    await api.post('/users', user.toJson());
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await api.put('/users/${user.id}', user.toJson());
  }

  @override
  Future<void> deleteUser(String id) async {
    await api.delete('/users/$id');
  }
}
