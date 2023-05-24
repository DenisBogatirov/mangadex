// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';

@injectable
class GetContentRatingStreamUseCase {
  final SettingsRepository _settingsRepository;

  GetContentRatingStreamUseCase(this._settingsRepository);

  StreamSubscription<List<MangaContentRating>> call(ValueChanged<List<MangaContentRating>> callback) {
    return _settingsRepository.contentRatingStream.listen(callback);
  }
}
