// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/use_cases/get_session_toke.use_case.dart';

@Injectable()
class SessionTokenInterceptor extends Interceptor {
  final GetAuthTokenUseCase _sessionTokenUseCase;

  SessionTokenInterceptor(this._sessionTokenUseCase);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _sessionTokenUseCase();
      options.headers[HttpHeaders.authorizationHeader] = 'Bearer ${token.sessionToken}';
    } catch(e, st) {
      debugPrint('Failed to add Session token: $st');
    }

    super.onRequest(options, handler);
  }
}
