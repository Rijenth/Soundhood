class User {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String? profileName;
  final String? description;
  final String? instruments;
  final String? influences;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    this.profileName,
    this.description,
    this.instruments,
    this.influences,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email_address': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };

    if (profileName?.isNotEmpty == true) data['profile_name'] = profileName;
    if (description?.isNotEmpty == true) data['description'] = description;
    if (instruments?.isNotEmpty == true) {
      data['played_instruments'] = instruments;
    }
    if (influences?.isNotEmpty == true) data['musical_influences'] = influences;

    return data;
  }
}
