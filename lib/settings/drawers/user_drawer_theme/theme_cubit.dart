// Package imports:
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/use_cases/get_current_theme.use_case.dart';
import 'package:mangadex/settings/domain/use_cases/save_theme.use_case.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

@singleton
class ThemeCubit extends Cubit<UserTheme> {
  final GetCurrentThemeUseCase _getCurrentThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  ThemeCubit(
    this._getCurrentThemeUseCase,
    this._setThemeUseCase,
  ) : super(UserTheme.system) {
    _init();
  }

  Future<void> _init() async {
    emit(await _getCurrentThemeUseCase());
  }

  Future<void> changeTheme(UserTheme theme) async {
    emit(theme);
    await _setThemeUseCase(theme);
  }
}
