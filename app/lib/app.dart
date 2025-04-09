import 'package:SoundHood/v1/screens/start_screen.dart';
import 'package:flutter/material.dart';

class MusiciansApp extends StatelessWidget {
  const MusiciansApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musicians Network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const StartScreen(),
    );
  }
}
