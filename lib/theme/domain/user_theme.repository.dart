// Project imports:
import 'package:mangadex/theme/domain/user_theme.dart';

abstract interface class UserThemeRepository {
  Future<UserTheme> getTheme();
  Future<void> saveTheme(UserTheme theme);
}
