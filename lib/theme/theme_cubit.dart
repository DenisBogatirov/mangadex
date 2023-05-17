// Package imports:
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/theme/domain/user_theme.dart';
import 'use_cases/get_current_theme.use_case.dart';
import 'use_cases/save_theme.use_case.dart';

@injectable
class ThemeCubit extends Cubit<UserTheme> {
  final GetCurrentThemeUseCase _getCurrentThemeUseCase;
  final SaveThemeUseCase _saveThemeUseCase;

  ThemeCubit(
    this._getCurrentThemeUseCase,
    this._saveThemeUseCase,
  ) : super(UserTheme.system) {
    _init();
  }

  Future<void> _init() async {
    emit(await _getCurrentThemeUseCase());
  }

  Future<void> changeTheme(UserTheme theme) async {
    emit(theme);
    await _saveThemeUseCase(theme);
  }
}
