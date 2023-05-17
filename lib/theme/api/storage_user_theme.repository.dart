// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/infrastructure/store_interactor.dart';
import 'package:mangadex/theme/domain/user_theme.dart';
import 'package:mangadex/theme/domain/user_theme.repository.dart';

class _UserThemeMapper {
  final _enumKeyMap = {for (final theme in UserTheme.values) theme: theme.toString()};
  final _stringKeyMap = {for (final theme in UserTheme.values) theme.toString(): theme};

  String themeToString(UserTheme theme) => _enumKeyMap[theme]!;

  UserTheme themeFromString(String theme) => _stringKeyMap[theme]!;
}

@LazySingleton(as: UserThemeRepository)
class StorageUserThemeRepository implements UserThemeRepository {
  final StoreInteractor _storeInteractor;
  final _UserThemeMapper _userThemeMapper = _UserThemeMapper();

  StorageUserThemeRepository(this._storeInteractor);

  @override
  Future<UserTheme> getTheme() async {
    final themeString = await _storeInteractor.getTheme();
    return themeString != null ? _userThemeMapper.themeFromString(themeString) : UserTheme.system;
  }

  @override
  Future<void> saveTheme(UserTheme theme) async {
    return _storeInteractor.setTheme(_userThemeMapper.themeToString(theme));
  }
}
