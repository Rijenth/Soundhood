import 'package:flutter/material.dart';
import 'register_step_two_page.dart';
import '../widgets/logo_widget.dart';
import '../widgets/default_action_button.dart';

class RegisterStepOnePage extends StatelessWidget {
  const RegisterStepOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final lastNameController = TextEditingController();
    final firstNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const LogoWidget(),
                const SizedBox(height: 40),

                _buildTextField("Nom", lastNameController),
                const SizedBox(height: 16),

                _buildTextField("Prénom", firstNameController),
                const SizedBox(height: 16),

                _buildEmailField(emailController),
                const SizedBox(height: 16),

                _buildTextField("Mot de passe", passwordController, obscure: true),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: DefaultActionButton(
                    text: "Continuer",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterStepTwoPage(
                              email: emailController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              password: passwordController.text,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Déjà un compte ? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Connectez-vous",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Champ requis';
        }
        return null;
      },
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

  Widget _buildEmailField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Veuillez entrer une adresse email';
        }
        final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Adresse email invalide';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Adresse mail",
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