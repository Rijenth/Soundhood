import 'package:flutter/material.dart';

/// Custom reusable input field for auth forms.
class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const AuthInputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
