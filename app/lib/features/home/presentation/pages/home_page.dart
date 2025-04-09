import 'package:flutter/material.dart';

/// Main dashboard page after login.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SoundHood")),
      body: const Center(
        child: Text("Welcome to SoundHood!"),
      ),
    );
  }
}
