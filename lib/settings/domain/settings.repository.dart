// Project imports:
import 'content_rating.dart';
import 'user_theme.dart';

abstract interface class SettingsRepository {
  Future<void> syncSettings();

  Stream<UserTheme> get themeStream;
  Future<void> saveTheme(UserTheme theme);

  Future<List<MangaContentRating>> getContentRating();
  Future<void> setContentRating(List<MangaContentRating> rating);
}
