import 'dart:convert';
import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/models/event.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EventService extends ApiService {

  Future<List<Event>?> getAllEvents(BuildContext context) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    return await handleRequest(
      context: context,
      request: () => http.get(
        Uri.parse('$baseUrl/events'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ),
    onSuccess: (response) {
      final events = response.map<Event>((json) => Event.fromJson(json)).toList();
      return events;
      }
    );
  }

  Future<void> createEvent(
      BuildContext context,
      Map<String, dynamic> eventData,
      ) async {
    final authProvider = context.read<AuthProvider>();
    final jwt = authProvider.jwtToken;

    if (jwt.isEmpty) {
      ToastHelper.showError(context, "Utilisateur non authentifié");
      return;
    }

    await handleRequest(
      context: context,
      request: () => http.post(
        Uri.parse('$baseUrl/events'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(eventData),
      ),
      onSuccess: (response) {
        ToastHelper.showSuccess(context, "Événement créé avec succès");
      },
    );
  }

  Future<Event?> getEventById(BuildContext context, int eventId) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    return await handleRequest(
      context: context,
      request: () => http.get(
        Uri.parse('$baseUrl/events/$eventId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ),
      onSuccess: (response) {
        if (response is Map<String, dynamic>) {
          return Event.fromJson(response);
        }
        return null;
      },
    );
  }


  Future<void> updateEvent(
      BuildContext context,
      String eventId,
      Map<String, dynamic> updatedData,
      ) async {
    final authProvider = context.read<AuthProvider>();
    final jwt = authProvider.jwtToken;

    if (jwt.isEmpty) {
      ToastHelper.showError(context, "Utilisateur non authentifié");
      return;
    }

    await handleRequest(
      context: context,
      request: () => http.put(
        Uri.parse('$baseUrl/events/$eventId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      ),
      onSuccess: (response) {
        ToastHelper.showSuccess(context, "Événement mis à jour avec succès");
      },
    );
  }

  Future<void> addParticipantToEvent(
      BuildContext context,
      int eventId,
      int userId,
      ) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    await handleRequest(
      context: context,
      request: () => http.put(
        Uri.parse('$baseUrl/events/$eventId/add-participant/$userId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ),
      onSuccess: (response) {
        ToastHelper.showSuccess(context, "Participant ajouté à l'événement !");
      },
    );
  }

  Future<List<Event>?> getEventsByParticipant(
      BuildContext context,
      int userId,
      ) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    return await handleRequest(
      context: context,
      request: () => http.get(
        Uri.parse('$baseUrl/events/participations/$userId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ),
      onSuccess: (response) {
        if (response is List) {
          return response.map((event) => Event.fromJson(event)).toList();
        }
        return null;
      },
    );
  }

  Future<void> deleteEvent(BuildContext context, int eventId) async {
    final jwt = context.read<AuthProvider>().jwtToken;

    await handleRequest(
      context: context,
      request: () => http.delete(
        Uri.parse('$baseUrl/events/$eventId'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ),
      onSuccess: (response) {
        ToastHelper.showSuccess(context, "Événement supprimé !");
      },
    );
  }
}
