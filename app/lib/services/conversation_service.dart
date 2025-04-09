import 'dart:convert';
import 'package:SoundHood/models/conversation.dart';
import 'package:SoundHood/models/message.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/api_service.dart';
import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ConversationService {
  final ApiService _apiService = ApiService();

  Future<List<Conversation>> getUserConversations(
      BuildContext context,
      String userId,
      ) async {
    final jwtToken = Provider.of<AuthProvider>(context, listen: false).jwtToken;

    try {
      final response = await http.get(
        Uri.parse('${_apiService.baseUrl}/users/$userId/conversations'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => Conversation.fromJson(e))
            .toList();
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? _apiService.baseErrorMessage);
        return [];
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return [];
    }
  }

  Future<Conversation?> createConversation(
      BuildContext context,
      String userId,
      String otherUserId,
      ) async {
    try {
      final jwtToken = Provider.of<AuthProvider>(context, listen: false).jwtToken;

      final response = await http.post(
        Uri.parse('${_apiService.baseUrl}/users/$userId/conversations'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'id': otherUserId}),
      );

      if (response.statusCode == 201) {
        return Conversation.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? _apiService.baseErrorMessage);
        return null;
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return null;
    }
  }

  Future<List<Message>> getConversationMessages(
      BuildContext context,
      String conversationId,
      ) async {
    try {
      final jwtToken = Provider.of<AuthProvider>(context, listen: false).jwtToken;

      final response = await http.get(
        Uri.parse('${_apiService.baseUrl}/conversations/$conversationId/messages'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((e) => Message.fromJson(e))
            .toList();
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? _apiService.baseErrorMessage);
        return [];
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return [];
    }
  }

  Future<Message?> sendMessage(
      BuildContext context,
      String conversationId,
      String messageContent,
      String senderId,
      ) async {
    try {
      final jwtToken = Provider.of<AuthProvider>(context, listen: false).jwtToken;

      final response = await http.post(
        Uri.parse('${_apiService.baseUrl}/conversations/$conversationId/messages'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'message': messageContent, 'userId': senderId}),
      );

      if (response.statusCode == 201) {
        return Message.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        ToastHelper.showError(context, error['message'] ?? _apiService.baseErrorMessage);
        return null;
      }
    } catch (e) {
      ToastHelper.showError(context, e.toString());
      return null;
    }
  }
}