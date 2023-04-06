// import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshTokenInterceptor extends QueuedInterceptor {
  late Dio dio;

  void set(Dio dio) {
    this.dio = dio;
  }
  //
  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   if (err.response?.statusCode == HttpStatus.unauthorized) {
  //     handler.reject(err);
  //   } else {
  //     return handler.next(err);
  //   }
  // }
}
