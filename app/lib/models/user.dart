class User {
  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String? profileName;
  final String? description;
  final String? instruments;
  final String? influences;
  final String? username;
  final bool? isOnline;

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    this.profileName,
    this.description,
    this.instruments,
    this.influences,
    this.username,
    this.isOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email_address'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      password: json['password'] ?? '',
      profileName: json['profile_name'],
      description: json['description'],
      instruments: json['played_instruments'],
      influences: json['musical_influences'],
      username: json['username'],
      isOnline: json['online'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'email_address': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
    };

    if (profileName?.isNotEmpty == true) data['profile_name'] = profileName;
    if (description?.isNotEmpty == true) data['description'] = description;
    if (instruments?.isNotEmpty == true) data['played_instruments'] = instruments;
    if (influences?.isNotEmpty == true) data['musical_influences'] = influences;
    if (username?.isNotEmpty == true) data['username'] = username;
    if (isOnline != null) data['online'] = isOnline;

    return data;
  }

  @override
  String toString() {
    return 'User($firstName $lastName - $email - ${username ?? "no username"})';
  }
}