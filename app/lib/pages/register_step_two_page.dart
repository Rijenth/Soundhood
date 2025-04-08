import 'package:SoundHood/models/user.dart';
import 'package:SoundHood/services/authentication_service.dart';
import 'package:SoundHood/widgets/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterStepTwoPage extends StatelessWidget {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  const RegisterStepTwoPage({
    super.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    final profileNameController = TextEditingController();
    final descriptionController = TextEditingController();
    final instrumentsController = TextEditingController();
    final influencesController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.white),
        title: const Text("Créer votre profil", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          children: [
            ClipOval(
              child: SvgPicture.asset(
                'lib/assets/profile-default.svg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
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
                    onPressed: () => Navigator.pop(context),
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
                      onPressed: () async {
                        final authService = AuthenticationService();

                        final user = User(
                          email: email,
                          firstName: firstName,
                          lastName: lastName,
                          password: password,
                          profileName: profileNameController.text,
                          description: descriptionController.text,
                          instruments: instrumentsController.text,
                          influences: influencesController.text,
                        );

                        try {
                          final response = await authService.register(user);
                          print("Inscription réussie : $response");
                        } catch (e) {
                          print("Erreur : $e");
                        }
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