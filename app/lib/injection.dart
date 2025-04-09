import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/services/api_service.dart';

import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';
import 'core/services/token_service.dart';

import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';

final GetIt locator = GetIt.instance;

/// Configures all dependencies for the app.
Future<void> configureDependencies() async {
  // HTTP client
  locator.registerLazySingleton<http.Client>(() => http.Client());

  // ApiService
  locator.registerLazySingleton<ApiService>(
        () => ApiServiceImpl(baseUrl: 'https://your-api-url.com', client: locator()),
  );

  // DataSource
  locator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(locator<ApiService>()),
  );

  // Repository
  locator.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(locator<AuthRemoteDataSource>()),
  );

  // Use Cases
  locator.registerLazySingleton(() => LoginUser(locator<AuthRepository>()));
  locator.registerLazySingleton(() => RegisterUser(locator<AuthRepository>()));
  locator.registerLazySingleton(() => LogoutUser(locator<AuthRepository>()));
  locator.registerLazySingleton(() => TokenService());
}
