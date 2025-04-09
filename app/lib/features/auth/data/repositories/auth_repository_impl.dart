import '../../domain/entities/session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// AuthRepository implementation with JWT session management.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Session> login(String email, String password) async {
    final model = await remote.login(email, password);
    return model.toSession(password);
  }

  @override
  Future<Session> register(String email, String password) async {
    final model = await remote.register(email, password);
    return model.toSession(password);
  }

  @override
  Future<void> logout() => remote.logout();

  @override
  Future<bool> isAuthenticated() => remote.checkAuthStatus();
}
