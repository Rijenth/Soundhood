import 'package:flutter/material.dart';
import '../views/register_form_view.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: RegisterFormView(),
      ),
    );
  }
}
