// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/infrastructure/store_interactor.dart';

@Injectable()
class SignOutUseCase {
  final StoreInteractor _storeInteractor;

  SignOutUseCase(this._storeInteractor);

  Future<void> call() async {
    await _storeInteractor.removeSessionToken();
    await _storeInteractor.removeRefreshToken();
  }
}
