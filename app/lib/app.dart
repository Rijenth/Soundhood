import 'package:SoundHood/pages/home_page.dart';
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
      home: const HomeScreen(),
    );
  }
}