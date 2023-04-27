// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/domain/user.repository.dart';

@Injectable()
class GetCurrentUserUseCase {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._userRepository, this._authRepository);

  Future<User> call() async {
    if (await _authRepository.isSignedIn()) {
      return _userRepository.fetchCurrentUser();
    }

    return GuestUser();
  }
}
