import 'package:flutter/material.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Mes événements", style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text("Liste de mes événements", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}