// import 'dart:io';

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/use_cases/get_session_toke.use_case.dart';
import 'package:mangadex/auth/domain/use_cases/refresh_token.use_case.dart';
import 'package:mangadex/infrastructure/api_client/mangadex_dio.dart';

@Injectable()
class RefreshTokenInterceptor extends QueuedInterceptor {
  final GetAuthTokenUseCase _getAuthTokenUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  late final AuthorizedMangaDexDio _authorizedMangaDexDio;

  RefreshTokenInterceptor(
    this._getAuthTokenUseCase,
    this._refreshTokenUseCase,
  );

  void setAuthorizedDioClient(Dio dio) {
    _authorizedMangaDexDio = dio as AuthorizedMangaDexDio;
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        AuthToken token = await _getAuthTokenUseCase();
        if (err.requestOptions.headers[HttpHeaders.authorizationHeader] == 'Bearer ${token.sessionToken}') {
          await _refreshTokenUseCase();
          token = await _getAuthTokenUseCase();
        }
        return _retryRequest(err.requestOptions, handler, token.sessionToken);
      } catch (e) {
        return handler.next(err);
      }
    } else {
      return handler.next(err);
    }
  }

  Future<void> _retryRequest(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
    String sessionToken,
  ) async {
    final headers = requestOptions.headers;
    headers[HttpHeaders.authorizationHeader] = 'Bearer $sessionToken';
    try {
      final response = await _authorizedMangaDexDio.fetch(
        requestOptions.copyWith(
          headers: headers,
        ),
      );
      return handler.resolve(response);
    } on DioException catch (e) {
      return handler.next(e);
    }
  }
}
