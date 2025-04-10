import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/providers/auth_provider.dart';
import 'package:SoundHood/screens/authenticated/direct_message/conversation_message.dart';
import 'package:SoundHood/services/conversation_service.dart';
import 'package:SoundHood/services/user_service.dart';
import 'package:SoundHood/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/ToastHelper.dart';
import '../../widgets/main_bottom_navigation.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Future<List<User>> _fetchUsers(BuildContext context) async {
    final userService = UserService();
    final users = await userService.getAllUsers(context);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    print("je suis dans la page recherche");
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const MainBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Rechercher", style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.chat_bubble_outline, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(50),
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
            // Plusieurs éléments de recherche
            const SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<List<User>>(
                future: _fetchUsers(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Erreur : ${snapshot.error}", style: TextStyle(color: Colors.red)),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Aucun utilisateur", style: TextStyle(color: Colors.white)));
                  }

                  final users = snapshot.data!;
                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserCard(
                          name: user.firstName + " " + user.lastName,
                          region: user.email,
                          status: user.isOnline == true ? "En ligne" : "Hors ligne",
                          onTap: () async {
                            final authProvider = Provider.of<AuthProvider>(context, listen: false);
                            final currentUserId = authProvider.userID;

                            final conversationService = ConversationService();

                            final conversation = await conversationService.createConversation(
                              context,
                              currentUserId.toString(),
                              user.id.toString(),
                            );

                            if (conversation != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ConversationMessage(
                                    user: user,
                                    conversation: conversation,
                                  ),
                                ),
                              );
                            }
                          }
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
