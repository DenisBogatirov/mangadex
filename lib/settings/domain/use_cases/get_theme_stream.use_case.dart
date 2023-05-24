// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/settings.repository.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

@injectable
class GetThemeStreamUseCase {
  final SettingsRepository _repository;

  GetThemeStreamUseCase(this._repository);

  StreamSubscription<UserTheme> call(ValueChanged<UserTheme> callback) {
    return _repository.themeStream.listen(callback);
  }
}
