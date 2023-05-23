// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/settings.repository.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

@injectable
class SetThemeUseCase {
  final SettingsRepository _repository;

  SetThemeUseCase(this._repository);

  Future<void> call(UserTheme theme) async {
    return _repository.saveTheme(theme);
  }
}
