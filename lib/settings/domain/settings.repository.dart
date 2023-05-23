// Project imports:
import 'content_rating.dart';
import 'user_theme.dart';

abstract interface class SettingsRepository {
  Future<UserTheme> getTheme();
  Future<void> saveTheme(UserTheme theme);

  Future<List<MangaContentRating>> getContentRating();
  Future<void> setContentRating(List<MangaContentRating> rating);
}
