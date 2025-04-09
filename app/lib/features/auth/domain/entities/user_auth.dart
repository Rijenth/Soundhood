/// Represents a minimal authenticated user in the domain layer.
class UserAuth {
  final String uid;
  final String email;

  UserAuth({required this.uid, required this.email});
}
