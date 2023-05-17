// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

enum StoreInteractorKeys {
  sessionToken('SESSION_TOKEN'),
  refreshToken('REFRESH_TOKEN'),
  theme('THEME');

  const StoreInteractorKeys(this.name);

  final String name;
}

class StoreInteractor {
  final FlutterSecureStorage _secureStorage;

  static Future<StoreInteractor> create() async {
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    return StoreInteractor._(secureStorage);
  }

  StoreInteractor._(this._secureStorage);

  Future<String?> getSessionToken() async {
    return _secureStorage.read(key: StoreInteractorKeys.sessionToken.name);
  }

  Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: StoreInteractorKeys.refreshToken.name);
  }

  Future<void> setSessionToken(String token) async {
    await _secureStorage.write(key: StoreInteractorKeys.sessionToken.name, value: token);
  }

  Future<void> setRefreshToken(String token) async {
    await _secureStorage.write(key: StoreInteractorKeys.refreshToken.name, value: token);
  }

  Future<void> removeSessionToken() async {
    await _secureStorage.delete(key: StoreInteractorKeys.sessionToken.name);
  }

  Future<void> removeRefreshToken() async {
    await _secureStorage.delete(key: StoreInteractorKeys.refreshToken.name);
  }

  Future<String?> getTheme() async {
    return _secureStorage.read(key: StoreInteractorKeys.theme.name);
  }

  Future<void> setTheme(String theme) async {
    await _secureStorage.write(key: StoreInteractorKeys.theme.name, value: theme);
  }
}

@module
abstract class InteractorRegisterModule {
  @preResolve
  Future<StoreInteractor> get interactor => StoreInteractor.create();
}
