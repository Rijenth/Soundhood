import 'package:flutter/material.dart';
import 'app.dart';
import 'injection.dart';
import 'features/auth/presentation/blocs/auth_bloc_provider.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/logout_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(); // Setup for DI

  // Retrieve the auth use cases from service locator
  final loginUser = locator<LoginUser>();
  final registerUser = locator<RegisterUser>();
  final logoutUser = locator<LogoutUser>();

  runApp(
    AuthBlocProvider(
      loginUser: loginUser,
      registerUser: registerUser,
      logoutUser: logoutUser,
      child: const SoundHoodApp(),
    ),
  );
}
