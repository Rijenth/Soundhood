import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/logo_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/register_text_field.dart';
import '../widgets/register_email_field.dart';

/// First step of registration – personal and login info.
class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({super.key});

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      context.go('/auth/register/2', extra: {
        'lastName': _lastNameController.text,
        'firstName': _firstNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const LogoWidget(),
                const SizedBox(height: 40),
                RegisterTextField(hint: 'Nom', controller: _lastNameController),
                const SizedBox(height: 16),
                RegisterTextField(hint: 'Prénom', controller: _firstNameController),
                const SizedBox(height: 16),
                RegisterEmailField(controller: _emailController),
                const SizedBox(height: 16),
                RegisterTextField(
                  hint: 'Mot de passe',
                  controller: _passwordController,
                  obscure: true,
                  validator: validatePassword,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    text: 'Continuer',
                    onPressed: _goToNextStep,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Déjà un compte ? ", style: TextStyle(color: Colors.white70)),
                    GestureDetector(
                      onTap: () => context.go('/auth/login'),
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
}
