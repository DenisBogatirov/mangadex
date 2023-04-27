// Package imports:
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/interceptors/refresh_token_interceptor.dart';
import 'package:mangadex/infrastructure/api_client/interceptors/session_token_interceptor.dart';
import 'package:mangadex/infrastructure/app_env.dart';

const _defaultTimeout = Duration(seconds: 30);

@LazySingleton()
class MangaDexDio with DioMixin implements Dio {
  MangaDexDio(
    AppEnv appEnv,
    List<Interceptor> interceptors,
  ) {
    options = BaseOptions(
      baseUrl: appEnv.baseApiUrl,
      followRedirects: false,
      sendTimeout: _defaultTimeout,
      connectTimeout: _defaultTimeout,
      receiveTimeout: _defaultTimeout,
    );
    httpClientAdapter = IOHttpClientAdapter();
    _setupInterceptors(interceptors);
  }

  @factoryMethod
  factory MangaDexDio.create(
    AppEnv appEnv,
    PrettyDioLogger prettyDioLogger,
  ) =>
      MangaDexDio(
        appEnv,
        [prettyDioLogger],
      );

  void _setupInterceptors(List<Interceptor> interceptorList) {
    interceptorList.whereType<RefreshTokenInterceptor>().forEach((element) => element.setAuthorizedDioClient(this));
    interceptors.addAll(interceptorList);
  }
}

@LazySingleton()
class AuthorizedMangaDexDio extends MangaDexDio {
  AuthorizedMangaDexDio(
    AppEnv appEnv,
    SessionTokenInterceptor sessionTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
    PrettyDioLogger prettyDioLogger,
  ) : super(
          appEnv,
          [
            prettyDioLogger,
            sessionTokenInterceptor,
            refreshTokenInterceptor,
          ],
        );
}
