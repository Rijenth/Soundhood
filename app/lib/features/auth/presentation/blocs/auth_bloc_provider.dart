import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_bloc.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/logout_user.dart';

/// Provides AuthBloc to its subtree.
class AuthBlocProvider extends StatelessWidget {
  final Widget child;
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final LogoutUser logoutUser;

  const AuthBlocProvider({
    super.key,
    required this.child,
    required this.loginUser,
    required this.registerUser,
    required this.logoutUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        loginUser: loginUser,
        registerUser: registerUser,
        logoutUser: logoutUser,
      ),
      child: child,
    );
  }
}
