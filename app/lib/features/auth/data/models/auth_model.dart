import '../../domain/entities/user_auth.dart';

/// DTO representing user data returned from auth backend.
class AuthModel {
  final String uid;
  final String email;

  AuthModel({required this.uid, required this.email});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json['uid'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
  };

  UserAuth toEntity() => UserAuth(uid: uid, email: email);

  factory AuthModel.fromEntity(UserAuth user) =>
      AuthModel(uid: user.uid, email: user.email);
}
