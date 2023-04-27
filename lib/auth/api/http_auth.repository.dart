// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/api/auth.client.dart';
import 'package:mangadex/auth/api/dto/sign_in.dto.dart';
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/auth.exceptions.dart';
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/infrastructure/store_interactor.dart';

@LazySingleton(as: AuthRepository)
class HttpAuthRepository implements AuthRepository {
  final StoreInteractor _storeInteractor;
  final AuthClient _client;

  const HttpAuthRepository(
    this._client,
    this._storeInteractor,
  );

  @override
  Future<bool> isSignedIn() async {
    final sessionToken = await _storeInteractor.getSessionToken();

    return sessionToken != null;
  }

  @override
  Future<void> signInWith(SignInPayload payload) async {
    switch (payload.runtimeType) {
      case UsernamePayload:
        return _signInWithUsername(payload as UsernamePayload);
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    await _storeInteractor.removeSessionToken();
    await _storeInteractor.removeRefreshToken();
  }

  Future<void> _signInWithUsername(UsernamePayload payload) async {
    try {
      final response = await _client.signIn(SignInDTO.fromPayload(payload));

      _storeInteractor.setSessionToken(response.token.session);
      if (payload.rememberMe) {
        _storeInteractor.setRefreshToken(response.token.refresh);
      }
    } on DioError catch(e) {
      if (e.response?.statusCode == HttpStatus.unauthorized) {
        throw WrongSignInCredentialsException();
      }

      rethrow;
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    final response = await _client.refresh(RefreshTokenDTO(refreshToken));

    await _storeInteractor.setSessionToken(response.token.session);
    await _storeInteractor.setRefreshToken(response.token.refresh);
  }
}
