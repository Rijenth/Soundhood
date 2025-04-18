import 'dart:convert';

import 'package:SoundHood/models/conversation.dart';
import 'package:SoundHood/models/message.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:SoundHood/models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConversationMessage extends StatefulWidget {
  final User user;
  final Conversation conversation;

  const ConversationMessage(
      {super.key, required this.user, required this.conversation});

  @override
  State<ConversationMessage> createState() => _ConversationMessageState();

}

class _ConversationMessageState extends State<ConversationMessage> {
  final TextEditingController _messageController = TextEditingController();
  final ConversationService _conversationService = ConversationService();
  List<Message> _messages = [];
  bool _isLoading = true;

  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();
    // Charger les messages au démarrage
    _fetchMessages();

    // 👇 Connexion WebSocket
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://a976-2a0d-e487-122f-edd2-eda1-a5c9-d901-252.ngrok-free.app/ws/conversations/${widget.conversation.id}'),
    );

    _channel.stream.listen((data) {
      print("📥 Nouveau message WebSocket : $data");

      final jsonData = json.decode(data);
      final newMessage = Message.fromJson(jsonData);

      if (!mounted) return;

      setState(() {
        if (!_messages.contains(newMessage)) {
          _messages.add(newMessage);
        }
      });
    });
  }

  Future<void> _fetchMessages() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Utiliser l'ID de conversation pour récupérer les messages
      final messages = await _conversationService.getConversationMessages(
          context,
          widget.conversation.id.toString()
      );

      if (!mounted) return;

      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
      // Gérer l'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du chargement des messages: ${e.toString()}")),
      );
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUserId = authProvider.userID;

    try {
      final newMessage = await _conversationService.sendMessage(
          context,
          widget.conversation.id.toString(),
          _messageController.text.trim(),
          currentUserId.toString()
      );
      if (!mounted) return;

      if (newMessage != null) {
        setState(() {
          // if (!_messages.contains(newMessage)) {
          //   _messages.add(newMessage);
          // }
          _messageController.clear();
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'envoi du message: ${e.toString()}")),
      );
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${widget.user.firstName} ${widget.user.lastName}';
    final region = widget.user.email;
    final status = (widget.user.isOnline ?? false) ? "En ligne" : "Hors ligne";
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUserId = authProvider.userID;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Row(
          children: [
            ClipOval(
              child: SvgPicture.asset(
                'lib/assets/profile-default.svg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              fullName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 💬 Liste des messages ou profil si vide
          Expanded(
            child: _messages.isEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    'lib/assets/profile-default.svg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  fullName,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(region,
                    style: const TextStyle(color: Colors.white60, fontSize: 16)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Voir le profil'),
                ),
              ],
            )
                : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                bool isCurrentUser = message.userId == currentUserId.toString();

                return Align(
                  alignment:
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color:
                      isCurrentUser ? Colors.blueAccent : Colors.grey[700],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.content,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          // 📝 Zone de message fixe en bas
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(bottom: 12, top: 4),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Taper votre message...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: const Icon(Icons.send, color: Colors.white),
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