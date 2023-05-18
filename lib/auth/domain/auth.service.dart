// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  late final Stream<void> _signOutStream;
  late final Stream<void> _signInStream;
  late final StreamController<void> _signOutSink;
  late final StreamController<void> _signInSink;

  AuthService() {
    _signOutSink = StreamController.broadcast();
    _signInSink = StreamController.broadcast();
    _signOutStream = _signOutSink.stream;
    _signInStream = _signInSink.stream;
  }

  void notifySignOut() {
    _signOutSink.add(null);
  }

  void notifySignIn() {
    _signInSink.add(null);
  }

  StreamSubscription<void> onSignOut(ValueChanged<void> callback) {
    return _signOutStream.listen(callback);
  }

  StreamSubscription<void> onSignIn(ValueChanged<void> callback) {
    return _signInStream.listen(callback);
  }

  void dispose() {
    _signOutSink.close();
    _signInSink.close();
  }
}
