// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/use_cases/get_theme_stream.use_case.dart';
import 'package:mangadex/settings/domain/use_cases/save_theme.use_case.dart';
import 'package:mangadex/settings/domain/user_theme.dart';

@singleton
class ThemeCubit extends Cubit<UserTheme> {
  final GetThemeStreamUseCase _getThemeStreamUseCase;
  final SetThemeUseCase _setThemeUseCase;
  late final StreamSubscription<UserTheme> _themeSubscription;

  ThemeCubit(
    this._getThemeStreamUseCase,
    this._setThemeUseCase,
  ) : super(UserTheme.system) {
    _themeSubscription = _getThemeStreamUseCase(_onThemeUpdate);
  }

  void _onThemeUpdate(UserTheme theme) {
    emit(theme);
  }

  Future<void> changeTheme(UserTheme theme) async {
    emit(theme);
    await _setThemeUseCase(theme);
  }

  @override
  Future<void> close() {
    _themeSubscription.cancel();
    return super.close();
  }
}
