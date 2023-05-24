// Project imports:
import 'content_rating.dart';
import 'user_theme.dart';

abstract interface class SettingsRepository {
  Future<void> syncSettings();

  Stream<UserTheme> get themeStream;
  Future<void> saveTheme(UserTheme theme);

  Stream<List<MangaContentRating>> get contentRatingStream;
  Future<void> setContentRating(List<MangaContentRating> rating);
}
