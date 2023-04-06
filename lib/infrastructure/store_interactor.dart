// Package imports:
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StoreInteractorKeys {
  sessionToken('SESSION_TOKEN'),
  refreshToken('REFRESH_TOKEN');

  const StoreInteractorKeys(this.name);

  final String name;
}

class StoreInteractor {
  final SharedPreferences _sharedPreferences;

  static Future<StoreInteractor> create() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return StoreInteractor._(sharedPreferences);
  }

  StoreInteractor._(this._sharedPreferences);

  Future<String?> getSessionToken() async {
    return _sharedPreferences.getString(StoreInteractorKeys.sessionToken.name);
  }

  Future<String?> getRefreshToken() async {
    return _sharedPreferences.getString(StoreInteractorKeys.refreshToken.name);
  }

  Future<void> setSessionToken(String token) async {
    await _sharedPreferences.setString(StoreInteractorKeys.sessionToken.name, token);
  }

  Future<void> setRefreshToken(String token) async {
    await _sharedPreferences.setString(StoreInteractorKeys.refreshToken.name, token);
  }

  Future<void> removeSessionToken() async {
    await _sharedPreferences.remove(StoreInteractorKeys.sessionToken.name);
  }

  Future<void> removeRefreshToken() async {
    await _sharedPreferences.remove(StoreInteractorKeys.refreshToken.name);
  }
}

@module
abstract class InteractorRegisterModule {
  @preResolve
  Future<StoreInteractor> get interactor => StoreInteractor.create();
}
