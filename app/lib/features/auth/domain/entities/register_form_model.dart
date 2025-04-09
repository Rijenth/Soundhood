import '../../../users/domain/entities/user.dart';
import 'credentials.dart';

class RegisterFormModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  final String? profileName;
  final String? description;
  final String? instruments;
  final String? influences;

  RegisterFormModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.profileName,
    this.description,
    this.instruments,
    this.influences,
  });

  Map<String, dynamic> toMap() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'profileName': profileName,
    'description': description,
    'instruments': instruments,
    'influences': influences,
  };

  factory RegisterFormModel.fromMap(Map<String, dynamic> map) {
    return RegisterFormModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      password: map['password'],
      profileName: map['profileName'],         // null accepté
      description: map['description'],
      instruments: map['instruments'],
      influences: map['influences'],
    );
  }

  /// Convertit vers User (quand toutes les données sont présentes)
  User toUser({required String id}) {
    return User(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      profileName: profileName ?? '',
      description: description ?? '',
      instruments: instruments ?? '',
      influences: influences ?? '',
    );
  }

  Credentials toCredentials() => Credentials(email: email, password: password);
}
