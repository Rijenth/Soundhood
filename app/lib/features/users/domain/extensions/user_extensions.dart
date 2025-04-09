import '../../../auth/domain/entities/credentials.dart';
import '../entities/user.dart';

/// Extension on User entity to convert into Credentials.
extension CredentialsFromUser on User {
  Credentials toCredentials(String password) {
    return Credentials(email: email, password: password);
  }
}
