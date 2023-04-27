// Project imports:
import 'package:mangadex/auth/domain/auth.dart';

abstract class AuthRepository {
  Future<void> signInWith(SignInPayload payload);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<void> refreshToken(String refreshToken);
}
