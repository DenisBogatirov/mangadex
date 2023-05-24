// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/infrastructure/store_interactor.dart';
import 'package:mangadex/settings/api/settings.client.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

const _separator = ',';

class _UserThemeMapper {
  final _enumKeyMap = {for (final theme in UserTheme.values) theme: theme.toString()};
  final _stringKeyMap = {for (final theme in UserTheme.values) theme.toString(): theme};

  String themeToString(UserTheme theme) => _enumKeyMap[theme]!;

  UserTheme themeFromString(String theme) => _stringKeyMap[theme]!;
}

@Singleton(as: SettingsRepository)
class CombinedSettingsRepository implements SettingsRepository {
  final StoreInteractor _storeInteractor;
  final SettingsClient _settingsClient;
  final AuthRepository _authRepository;
  final _UserThemeMapper _userThemeMapper = _UserThemeMapper();

  CombinedSettingsRepository(this._storeInteractor, this._settingsClient, this._authRepository) {
    syncSettings();
  }

  @override
  Future<void> syncSettings() async {
    if (await _authRepository.isSignedIn()) {
      final dto = await _settingsClient.getSettings();
    }
  }

  @override
  Future<UserTheme> getTheme() async {
    final themeString = await _storeInteractor.getTheme();
    return themeString != null ? _userThemeMapper.themeFromString(themeString) : UserTheme.system;
  }

  @override
  Future<void> saveTheme(UserTheme theme) async {
    return _storeInteractor.setTheme(_userThemeMapper.themeToString(theme));
  }

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
