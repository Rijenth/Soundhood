import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';

/// Reusable email input field with validation.
class RegisterEmailField extends StatelessWidget {
  final TextEditingController controller;

  const RegisterEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validateEmail,
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
