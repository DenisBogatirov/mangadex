// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';

abstract interface class SettingsRepository {
  Future<List<MangaContentRating>> getContentRating();
  Future<void> setContentRating(List<MangaContentRating> rating);
}
