// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/auth.repository.dart';

@Injectable()
class SignInWithUseCase {
  final AuthRepository _authRepository;

  SignInWithUseCase(this._authRepository);

  Future<void> call(SignInPayload payload) async {
    await _authRepository.signInWith(payload);
  }
}
