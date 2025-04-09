import 'auth_remote_datasource.dart';
import '../models/auth_model.dart';
import '../../../../core/services/api_service.dart';

/// Implementation of remote auth via ApiService.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<AuthModel> login(String email, String password) async {
    final response = await api.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return AuthModel.fromJson(response);
  }

  @override
  Future<AuthModel> register(String email, String password) async {
    final response = await api.post('/auth/register', {
      'email': email,
      'password': password,
    });
    return AuthModel.fromJson(response);
  }

  @override
  Future<void> logout() async {
    await api.post('/auth/logout', {});
  }

  @override
  Future<bool> checkAuthStatus() async {
    final response = await api.get('/auth/status');
    return response['authenticated'] == true;
  }
}
