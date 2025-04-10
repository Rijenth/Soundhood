import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SoundHood/models/event.dart';
import 'package:SoundHood/services/event_service.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:intl/intl.dart';


class IncomingEventsScreen extends StatefulWidget {
  const IncomingEventsScreen({super.key});

  @override
  State<IncomingEventsScreen> createState() => _IncomingEventsScreenState();
}

class _IncomingEventsScreenState extends State<IncomingEventsScreen> {
  final EventService _eventService = EventService();
  List<Event> _upcomingEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final allEvents = await _eventService.getAllEvents(context);
      if (!mounted) return;

      final now = DateTime.now();

      final upcoming = allEvents
          ?.where((event) =>
      event.startDate != null &&
          DateTime.parse(event.startDate!).isAfter(now))
          .toList() ??
          [];

      setState(() {
        _upcomingEvents = upcoming;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : ${e.toString()}")),
      );
    }
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    final date = DateTime.parse(isoDate);
    return DateFormat('dd MMM yyyy • HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Événements à venir'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _upcomingEvents.isEmpty
          ? const Center(
        child: Text(
          'Aucun événement à venir',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: _upcomingEvents.length,
        itemBuilder: (context, index) {
          final event = _upcomingEvents[index];
          return Card(
            margin: const EdgeInsets.all(12),
            color: Colors.grey[900],
            child: ListTile(
              title: Text(event.name,
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                '${_formatDate(event.startDate)}',
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                // TODO: Naviguer vers les détails de l'événement
              },
            ),
          );
        },
      ),
    );
  }
}