// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';

@injectable
class GetContentRatingUseCase {
  final SettingsRepository _settingsRepository;

  GetContentRatingUseCase(this._settingsRepository);

  Future<List<MangaContentRating>> call() async {
    return _settingsRepository.getContentRating();
  }
}
