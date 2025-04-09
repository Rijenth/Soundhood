import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';

/// Standard registration input field.
class RegisterTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final String? Function(String?)? validator;

  const RegisterTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator ?? validateRequired,
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
