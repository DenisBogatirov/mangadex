// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/theme/domain/user_theme.dart';
import 'package:mangadex/theme/domain/user_theme.repository.dart';

@injectable
class GetCurrentThemeUseCase {
  final UserThemeRepository _repository;

  GetCurrentThemeUseCase(this._repository);

  Future<UserTheme> call() async {
    return _repository.getTheme();
  }
}
