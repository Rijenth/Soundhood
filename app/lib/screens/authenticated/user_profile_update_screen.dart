import 'package:flutter/material.dart';
import '../../widgets/default_action_button.dart';
import '../../widgets/main_bottom_navigation.dart';
import '../authenticated/home_screen.dart';

class UserProfileUpdateScreen extends StatelessWidget {
  const UserProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final instrumentsController = TextEditingController();
    final influencesController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const MainBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text("Modifier votre profil", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            // Avatar
            Stack(
              alignment: Alignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/profile-default.jpg'),
                  radius: 60,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.edit, size: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Nom de profil", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 32),

            _buildTextField("Nom de profil", profileNameController),
            const SizedBox(height: 16),
            _buildTextField("Description", descriptionController),
            const SizedBox(height: 16),
            _buildTextField("Instruments joués", instrumentsController),
            const SizedBox(height: 16),
            _buildTextField("Influences musicales", influencesController),
            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("Annuler"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DefaultActionButton(
                    text: "Valider",
                    onPressed: () {
                      final updatedProfile = {
                        'profile_name': profileNameController.text,
                        'description': descriptionController.text,
                        'played_instruments': instrumentsController.text,
                        'musical_influences': influencesController.text,
                      };
                      print("Mise à jour du profil : $updatedProfile");
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white10,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
