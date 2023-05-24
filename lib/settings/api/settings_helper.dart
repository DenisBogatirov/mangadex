// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/user_theme.dart';
import 'dto/settings.dto.dart';

class SettingsHelper {
  static final _userThemeKeyMap = {for (final theme in UserTheme.values) theme: theme.name.toString()};
  static final _stringUserThemeKeyMap = {for (final theme in UserTheme.values) theme.name.toString(): theme};

  static String themeToString(UserTheme theme) => _userThemeKeyMap[theme]!;
  static UserTheme _themeFromString(String theme) => _stringUserThemeKeyMap[theme]!;

  static UserTheme themeFromSettings(SettingsWrapperDTO settingsWrapper) {
    return _themeFromString(settingsWrapper.settings.userPreferences.theme);
  }

  static List<MangaContentRating> ratingsFromSettings(SettingsWrapperDTO settingsWrapper) {
    final preferences = settingsWrapper.settings.userPreferences;
    final ratings = <MangaContentRating>[];

    if (preferences.showSafe) {
      ratings.add(MangaContentRating.safe);
    }

    if (preferences.showSuggestive) {
      ratings.add(MangaContentRating.suggestive);
    }

    if (preferences.showErotic) {
      ratings.add(MangaContentRating.erotica);
    }

    if (preferences.showHentai) {
      ratings.add(MangaContentRating.pornographic);
    }

    return ratings;
  }
}

extension SettingsHelperExtension on SettingsWrapperDTO {
  SettingsWrapperDTO copyWithTheme(UserTheme theme) {
    return copyWith(
      settings: settings.copyWith(
        userPreferences: settings.userPreferences.copyWith(
          theme: SettingsHelper.themeToString(theme),
        ),
      ),
    );
  }

  SettingsWrapperDTO copyWithRatings(List<MangaContentRating> ratings) {
    return copyWith(
      settings: settings.copyWith(
        userPreferences: settings.userPreferences.copyWith(
          showSafe: ratings.contains(MangaContentRating.safe),
          showSuggestive: ratings.contains(MangaContentRating.suggestive),
          showErotic: ratings.contains(MangaContentRating.erotica),
          showHentai: ratings.contains(MangaContentRating.pornographic),
        ),
      ),
    );
  }
}
