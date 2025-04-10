import 'package:SoundHood/helpers/ToastHelper.dart';
import 'package:SoundHood/services/authentication_service.dart';
import 'package:SoundHood/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/user_service.dart';
import '../../widgets/default_action_button.dart';
import '../../widgets/main_bottom_navigation.dart';
import '../../screens/authenticated/home_screen.dart';

class UserProfileUpdateScreen extends StatefulWidget {
  const UserProfileUpdateScreen({super.key});

  @override
  State<UserProfileUpdateScreen> createState() =>
      _UserProfileUpdateScreenState();
}

class _UserProfileUpdateScreenState extends State<UserProfileUpdateScreen> {
  final profileNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final instrumentsController = TextEditingController();
  final influencesController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      var fetchProfile = await AuthenticationService().me(context);

      final profile = {
        "profile_name": fetchProfile?['profile_name'] ?? '',
        "description": fetchProfile?['description'] ?? '',
        "played_instruments": fetchProfile?['played_instruments'] ?? '',
        "musical_influences": fetchProfile?['musical_influences'] ?? '',
      };

      profileNameController.text = profile['profile_name'];
      descriptionController.text = profile['description'];
      instrumentsController.text = profile['played_instruments'];
      influencesController.text = profile['musical_influences'];
    } catch (e) {
      ToastHelper.showError(
        context,
        "Une erreur est survenue lors de la récupération de votre profil",
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    profileNameController.dispose();
    descriptionController.dispose();
    instrumentsController.dispose();
    influencesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const MainBottomNavigation(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text(
          "Modifier votre profil",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    // Avatar SVG
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: SvgPicture.asset(
                            'lib/assets/profile-default.svg',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
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
                            child: const Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Nom de profil",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 32),

                    _buildTextField("Nom de profil", profileNameController),
                    const SizedBox(height: 16),
                    _buildTextField("Description", descriptionController),
                    const SizedBox(height: 16),
                    _buildTextField("Instruments joués", instrumentsController),
                    const SizedBox(height: 16),
                    _buildTextField(
                      "Influences musicales",
                      influencesController,
                    ),
                    const SizedBox(height: 32),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
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
                            onPressed: () async {
                              final updatedProfile = {
                                'profile_name': profileNameController.text,
                                'description': descriptionController.text,
                                'played_instruments':
                                    instrumentsController.text,
                                'musical_influences': influencesController.text,
                              };

                              await UserService().updateProfile(
                                context,
                                updatedProfile,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
