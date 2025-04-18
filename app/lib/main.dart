import 'package:flutter/material.dart';
import 'app.dart';

import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MusiciansApp(),
    ),
  );
}
