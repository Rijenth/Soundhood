import 'package:SoundHood/screens/authenticated/events/create_events_screen.dart';
import 'package:flutter/material.dart';
import 'events/incoming_events_screen.dart';
import 'events/my_events_screen.dart';
import '../../widgets/main_bottom_navigation.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Événements', style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.chat_bubble_outline, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      bottomNavigationBar: const MainBottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EventCard(
              title: 'Événements à venir',
              image: 'lib/assets/incoming.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IncomingEventsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            EventCard(
              title: 'Mes événements',
              image: 'lib/assets/my_events.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyEventsScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            EventCard(
              title: 'Organiser un événement',
              image: 'lib/assets/create_event.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EventCreateScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Image.asset(
              image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.black.withOpacity(0.4),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}