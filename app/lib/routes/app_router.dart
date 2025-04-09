import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/blocs/register_cubit_provider.dart';
import '../features/auth/presentation/pages/register_first_page.dart';
import '../features/auth/presentation/pages/register_second_page.dart';
import '../features/home/presentation/pages/home_page.dart';

/// Defines the application's route configuration using GoRouter.
final GoRouter appRouter = GoRouter(
  initialLocation: '/auth/welcome_page',
  routes: [
    GoRoute(
      path: '/auth/welcome_page',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/auth/register/1',
      builder: (context, state) => const RegisterCubitProvider(
        child: RegisterFirstPage(),
      ),
    ),
    GoRoute(
      path: '/auth/register/2',
      builder: (context, state) => const RegisterCubitProvider(
        child: RegisterSecondPage(),
      ),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),

    // Add more routes per feature here
  ],
);
