import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/button_widget.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../widgets/login_text_field.dart';

/// Login form used in LoginPage.
class LoginFormView extends StatefulWidget {
  const LoginFormView({super.key});

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LoginTextField(
            controller: _emailController,
            hint: 'Adresse mail',
            validator: validateEmail,
          ),
          const SizedBox(height: 16),
          LoginTextField(
            controller: _passwordController,
            hint: 'Mot de passe',
            obscure: true,
            validator: validatePassword,
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ButtonWidget(
              text: "Continuer",
              onPressed: _onSubmit,
            ),
          ),
          const SizedBox(height: 24),

          // Google
          _socialButton(
            label: "Se connecter avec Compte Google",
            icon: Icons.g_mobiledata,
            onPressed: () => debugPrint("Google login"),
          ),

          const SizedBox(height: 12),

          // Apple
          _socialButton(
            label: "Se connecter avec Compte Apple",
            icon: Icons.apple,
            onPressed: () => debugPrint("Apple login"),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Pas de compte ? ", style: TextStyle(color: Colors.white70)),
              GestureDetector(
                onTap: () => context.go('/auth/register/1'),
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
          )
        ],
      ),
    );
  }

  Widget _socialButton({required String label, required IconData icon, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
