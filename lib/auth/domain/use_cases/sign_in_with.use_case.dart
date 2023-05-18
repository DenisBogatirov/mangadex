// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/auth/domain/auth.service.dart';

@Injectable()
class SignInWithUseCase {
  final AuthRepository _authRepository;
  final AuthService _authService;

  SignInWithUseCase(this._authRepository, this._authService);

  Future<void> call(SignInPayload payload) async {
    await _authRepository.signInWith(payload);
    _authService.notifySignIn();
  }
}
