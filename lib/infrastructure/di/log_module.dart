// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _maxLogWidth = 120;

@module
abstract class LogModule {
  @injectable
  PrettyDioLogger get prettyDioLogger => PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    maxWidth: _maxLogWidth,
    logPrint: logPrinter,
  );
}

void logPrinter(Object object) {
  assert(() {
    debugPrint(object.toString());
    return true;
  }());
}
