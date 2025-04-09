import '../../domain/entities/credentials.dart';
import '../../domain/entities/session.dart';

/// DTO representing auth-related user data returned from the backend.
class AuthModel {
  final String uid;
  final String email;
  final String token;

  AuthModel({
    required this.uid,
    required this.email,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json['uid'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'token': token,
  };

  Credentials toCredentials(String password) =>
      Credentials(email: email, password: password);

  Session toSession(String password) => Session(
    credentials: toCredentials(password),
    token: token,
  );
}
