import '../../domain/entities/user.dart';

/// Data Transfer Object (DTO) for User, used in API communication.
class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String profileName;
  final String description;
  final String instruments;
  final String influences;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileName,
    required this.description,
    required this.instruments,
    required this.influences,
  });

  /// Creates a UserModel from JSON.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    profileName: json['profileName'],
    description: json['description'],
    instruments: json['instruments'],
    influences: json['influences'],
  );

  /// Converts UserModel to JSON (for API).
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'profileName': profileName,
    'description': description,
    'instruments': instruments,
    'influences': influences,
  };

  /// Converts this model to domain entity.
  User toEntity() => User(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    profileName: profileName,
    description: description,
    instruments: instruments,
    influences: influences,
  );

  /// Creates a model from domain entity.
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    firstName: user.firstName,
    lastName: user.lastName,
    profileName: user.profileName,
    description: user.description,
    instruments: user.instruments,
    influences: user.influences,
  );
}
