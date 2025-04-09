import '../../domain/entities/user_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementation of AuthRepository using remote data source.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserAuth> login(String email, String password) async {
    final model = await remote.login(email, password);
    return model.toEntity();
  }

  @override
  Future<UserAuth> register(String email, String password) async {
    final model = await remote.register(email, password);
    return model.toEntity();
  }

  @override
  Future<void> logout() => remote.logout();

  @override
  Future<bool> isAuthenticated() => remote.checkAuthStatus();
}
