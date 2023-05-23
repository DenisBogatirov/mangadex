// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/infrastructure/store_interactor.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';

const _separator = ',';

@LazySingleton(as: SettingsRepository)
class CombinedSettingsRepository implements SettingsRepository {
  final StoreInteractor _storeInteractor;

  CombinedSettingsRepository(this._storeInteractor);

  @override
  Future<List<MangaContentRating>> getContentRating() async {
    final ratingString = await _storeInteractor.getContentRating() ?? '';
    final strings = ratingString.isNotEmpty ? ratingString.split(_separator) : [];
    final ratings = <MangaContentRating>[];

    for (final str in strings) {
      ratings.add(MangaContentRating.values.firstWhere((e) => e.name == str));
    }

    return ratings;
  }

  @override
  Future<void> setContentRating(List<MangaContentRating> ratings) {
    return _storeInteractor.setContentRating(ratings.map((e) => e.name).join(_separator));
  }
}
