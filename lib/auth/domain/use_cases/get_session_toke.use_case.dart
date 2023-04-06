// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/auth.exceptions.dart';
import 'package:mangadex/infrastructure/store_interactor.dart';

@Injectable()
class GetAuthTokenUseCase {
  final StoreInteractor _storeInteractor;

  GetAuthTokenUseCase(this._storeInteractor);

  Future<AuthToken> call() async {
    final session = await _storeInteractor.getSessionToken();
    final refresh = await _storeInteractor.getRefreshToken();

    if (session == null) {
      throw NotSignedInException();
    }

    return AuthToken(
      sessionToken: session,
      refreshToken: refresh,
    );
  }
}
