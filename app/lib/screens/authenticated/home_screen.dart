import 'package:SoundHood/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../widgets/default_action_button.dart';
import '../../widgets/main_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMap = false;
  
  final authentificationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const MainBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text("Rechercher", style: TextStyle(color: Colors.white)),
        actions: [
          const Icon(Icons.chat_bubble_outline, color: Colors.white),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () => authentificationService.logout(context),
            child: const Icon(Icons.logout, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Map en arrière-plan
          if (showMap)
            FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(48.8708, 2.3316),
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.yourapp.id',
                ),
              ],
            ),

          // Barre de recherche en surimpression
          Positioned(
            top: 16,
            left: 24,
            right: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Chercher",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenu de base si la carte n'est pas encore affichée
          if (!showMap)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 24, right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Chercher un musicien grâce à\nnotre nouvelle fonctionnalité\nde géolocalisation",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 200,
                      child: DefaultActionButton(
                        text: "Afficher la carte",
                        onPressed: () {
                          setState(() {
                            showMap = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
