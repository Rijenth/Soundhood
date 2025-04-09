import 'package:flutter/material.dart';

/// Centralized theme configuration for the application.
class AppTheme {
  static final ThemeData light = ThemeData(
    primarySwatch: Colors.deepPurple,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: Colors.deepPurple,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
