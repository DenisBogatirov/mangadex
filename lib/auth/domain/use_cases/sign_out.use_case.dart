// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.service.dart';
import 'package:mangadex/infrastructure/store_interactor.dart';

@Injectable()
class SignOutUseCase {
  final StoreInteractor _storeInteractor;
  final AuthService _authService;

  SignOutUseCase(this._storeInteractor, this._authService);

  Future<void> call() async {
    await _storeInteractor.removeSessionToken();
    await _storeInteractor.removeRefreshToken();
    _authService.notifySignOut();
  }
}
