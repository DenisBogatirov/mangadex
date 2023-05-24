// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  late final Stream<bool> _signAuthState;
  late final StreamController<bool> _authStateSink;

  AuthService() {
    _authStateSink = StreamController.broadcast();
    _signAuthState = _authStateSink.stream;
  }

  void notifySignOut() {
    _authStateSink.add(false);
  }

  void notifySignIn() {
    _authStateSink.add(true);
  }

  StreamSubscription<void> onSignOut(ValueChanged<bool> callback) {
    return _signAuthState.where((isSignedIn) => !isSignedIn).listen(callback);
  }

  StreamSubscription<void> onSignIn(ValueChanged<bool> callback) {
    return _signAuthState.where((isSignedIn) => isSignedIn).listen(callback);
  }

  StreamSubscription<void> onAuthStateChange(ValueChanged<bool> callback) {
    return _signAuthState.listen(callback);
  }

  void dispose() {
    _authStateSink.close();
  }
}
