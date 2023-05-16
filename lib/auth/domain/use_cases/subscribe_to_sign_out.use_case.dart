// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.service.dart';

@injectable
class SubscribeToSignOutUseCase {
  final AuthService _authService;

  SubscribeToSignOutUseCase(this._authService);

  StreamSubscription<void> call(ValueChanged<void> callback) {
    return _authService.onSignOut(callback);
  }
}
