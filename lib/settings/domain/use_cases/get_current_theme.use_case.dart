// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/settings.repository.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

@injectable
class GetCurrentThemeUseCase {
  final SettingsRepository _repository;

  GetCurrentThemeUseCase(this._repository);

  Future<UserTheme> call() async {
    return _repository.getTheme();
  }
}
