import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/services/user_service.dart';
import 'package:SoundHood/widgets/user_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/main_bottom_navigation.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Future<List<User>> _fetchUsers(BuildContext context) async {
    final userService = UserService();
    final users = await userService.getAllUsers(context);
    print('UTILISATEURS FETCH : $users');
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
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return UserCard(
                        name: 'Nom de profil',
                        region: 'Région',
                        status: 'Statut sur l\'app',
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
