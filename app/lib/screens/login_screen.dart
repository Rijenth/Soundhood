import 'package:SoundHood/screens/register_step_one_screen.dart';
import 'package:SoundHood/services/authentication_service.dart';
import 'package:SoundHood/widgets/default_action_button.dart';
import 'package:flutter/material.dart';
import '../widgets/logo_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:SoundHood/helpers/ToastHelper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LogoWidget(),
              const SizedBox(height: 40),

              // Adresse mail
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Adresse mail',
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
              ),
              const SizedBox(height: 16),

              // Mot de passe
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
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
              ),
              const SizedBox(height: 24),

              // Bouton principal
              SizedBox(
                width: double.infinity,
                child: DefaultActionButton(
                  text: "Continuer",
                  onPressed: () async {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      ToastHelper.showError(
                        context,
                        "Veuillez remplir tous les champs obligatoires.",
                      );
                      return;
                    }

                    await AuthenticationService().login(
                      context,
                      email,
                      password,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Bouton Google
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => print("Connexion avec Google"),
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    color: Colors.black,
                  ),
                  label: const Text("Se connecter avec Compte Google"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Bouton Apple
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => print("Connexion avec Apple"),
                  icon: const Icon(FontAwesomeIcons.apple, color: Colors.black),
                  label: const Text("Se connecter avec Compte Apple"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Lien inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Pas de compte ? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => const LoginScreenRegisterStepOneScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Inscrivez-vous",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
