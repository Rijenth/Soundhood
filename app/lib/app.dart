import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

/// Root widget of the application.
class SoundHoodApp extends StatelessWidget {
  const SoundHoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SoundHood',
      theme: AppTheme.dark, // Custom theming
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
