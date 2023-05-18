// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.service.dart';

@injectable
class SubscribeToSignInUseCase {
  final AuthService _authService;

  SubscribeToSignInUseCase(this._authService);

  StreamSubscription<void> call(ValueChanged<void> callback) {
    return _authService.onSignIn(callback);
  }
}
