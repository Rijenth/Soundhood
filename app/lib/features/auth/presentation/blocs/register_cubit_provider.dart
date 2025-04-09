import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_cubit.dart';

/// Provides [RegisterCubit] to a subtree of widgets during registration flow.
class RegisterCubitProvider extends StatelessWidget {
  final Widget child;

  const RegisterCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(),
      child: child,
    );
  }
}
