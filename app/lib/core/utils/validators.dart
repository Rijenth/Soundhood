/// Validates if the given value is a proper email address.
String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Veuillez entrer une adresse email';
  }

  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Adresse email invalide';
  }

  return null;
}

/// Validates if the given value is a non-empty string.
String? validateRequired(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Champ requis';
  }
  return null;
}

/// Validates if the password meets minimum requirements.
String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mot de passe requis';
  }
  if (value.length < 6) {
    return 'Minimum 6 caractères';
  }
  return null;
}
