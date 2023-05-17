// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/theme/domain/user_theme.dart';
import 'package:mangadex/theme/domain/user_theme.repository.dart';

@injectable
class SaveThemeUseCase {
  final UserThemeRepository _repository;

  SaveThemeUseCase(this._repository);

  Future<void> call(UserTheme theme) async {
    return _repository.saveTheme(theme);
  }
}
