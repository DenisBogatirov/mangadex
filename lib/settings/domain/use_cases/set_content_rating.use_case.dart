// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';

@injectable
class SetContentRatingUseCase {
  final SettingsRepository _settingsRepository;

  SetContentRatingUseCase(this._settingsRepository);

  Future<void> call(List<MangaContentRating> ratings) async {
    return _settingsRepository.setContentRating(ratings);
  }
}
