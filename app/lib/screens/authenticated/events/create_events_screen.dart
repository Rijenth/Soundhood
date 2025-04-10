import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../../../services/event_service.dart';
import '../../../providers/auth_provider.dart';

class EventCreateScreen extends StatefulWidget {
  const EventCreateScreen({super.key});

  @override
  State<EventCreateScreen> createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxParticipantController = TextEditingController();

  DateTime _startDate = DateTime(2025, 4, 11, 20, 0);
  DateTime _endDate = DateTime(2025, 4, 11, 22, 0);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR');
  }

  Future<void> _selectDateTime({required bool isStart}) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: const Locale('fr', 'FR'),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(isStart ? _startDate : _endDate),
    );

    if (time == null) return;

    final selected = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      if (isStart) {
        _startDate = selected;
      } else {
        _endDate = selected;
      }
    });
  }

  String _formatDate(DateTime d) => DateFormat('d MMMM y', 'fr_FR').format(d);
  String _formatTime(DateTime d) => DateFormat('HH:mm').format(d);

  Future<void> _submitEvent() async {
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();
    final description = _descriptionController.text.trim();
    final maxParticipants = int.tryParse(_maxParticipantController.text.trim());

    if (name.isEmpty || location.isEmpty || description.isEmpty || maxParticipants == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs correctement.")),
      );
      return;
    }

    if (_endDate.isBefore(_startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("La date de fin doit être après la date de début.")),
      );
      return;
    }

    final data = {
      "name": name,
      "start_date": DateFormat("yyyy-MM-dd").format(_startDate),
      "end_date": DateFormat("yyyy-MM-dd").format(_endDate),
      "location": location,
      "description": description,
      "maxParticipant": maxParticipants,
    };

    try {
      final eventService = EventService();
      await eventService.createEvent(context, data);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Événement créé avec succès!")),
      );

      Navigator.pop(context); // Go back
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la création : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text("Organiser un événement", style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.chat_bubble_outline, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Nom de l’événement"),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildDateTime(
                    _formatDate(_startDate),
                    _formatTime(_startDate),
                        () => _selectDateTime(isStart: true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDateTime(
                    _formatDate(_endDate),
                    _formatTime(_endDate),
                        () => _selectDateTime(isStart: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Lieu de l’événement"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _maxParticipantController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("Nombre maximum de participants"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: _inputDecoration("Description"),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text("Annuler", style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Valider"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.grey[900],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }

  Widget _buildDateTime(String label, String time, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
