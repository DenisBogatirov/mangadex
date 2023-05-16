// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  late final Stream<void> _signOutStream;
  late final StreamController<void> _signOutSink;

  AuthService() {
    _signOutSink = StreamController.broadcast();
    _signOutStream = _signOutSink.stream;
  }

  void notifySignOut() {
    _signOutSink.add(null);
  }

  StreamSubscription<void> onSignOut(ValueChanged<void> callback) {
    return _signOutStream.listen(callback);
  }

  void dispose() {
    _signOutSink.close();
  }
}
