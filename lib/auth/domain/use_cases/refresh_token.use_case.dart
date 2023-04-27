// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/infrastructure/store_interactor.dart';

@Injectable()
class RefreshTokenUseCase {
  final AuthRepository _authRepository;
  final StoreInteractor _storeInteractor;

  RefreshTokenUseCase(this._authRepository, this._storeInteractor);

  Future<void> call() async {
    final refreshToken = await _storeInteractor.getRefreshToken();

    if (refreshToken == null) {
      // TODO: Proper error
      throw UnimplementedError();
    }


    await _authRepository.refreshToken(refreshToken);
  }
}
