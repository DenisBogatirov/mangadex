// Dart imports:
import 'dart:async';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.repository.dart';
import 'package:mangadex/auth/domain/auth.service.dart';
import 'package:mangadex/settings/api/dto/settings.dto.dart';
import 'package:mangadex/settings/api/settings.client.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/settings.repository.dart';
import 'package:mangadex/settings/domain/user_theme.dart';
import 'settings_helper.dart';

@Singleton(as: SettingsRepository, dispose: disposeCombinedSettingsRepository)
class CombinedSettingsRepository implements SettingsRepository {
  final SettingsClient _settingsClient;
  final AuthRepository _authRepository;
  final Isar _isar;

  late final StreamSubscription _authStateSub;

  CombinedSettingsRepository(
    this._settingsClient,
    this._authRepository,
    AuthService authService,
    this._isar,
  ) {
    _authStateSub = authService.onAuthStateChange(_onAuthStateChange);
    syncSettings();
  }

  void _onAuthStateChange(bool isSignedIn) {
    if (isSignedIn) {
      syncSettings();
    }
  }

  Future<SettingsWrapperDTO> _getSettings() async {
    return (await _isar.settings.get(SettingsWrapperDTO.constantId)) ?? SettingsWrapperDTO.empty();
  }

  @override
  Future<void> syncSettings() async {
    SettingsWrapperDTO dto = SettingsWrapperDTO.empty();

    if (await _authRepository.isSignedIn()) {
      dto = await _settingsClient.getSettings();
    }

    await _isar.writeTxn(() async {
      await _isar.settings.put(dto);
    });
  }

  @override
  Future<UserTheme> getTheme() async {
    final settingsWrapper = await _getSettings();
    return SettingsHelper.themeFromSettings(settingsWrapper);
  }

  @override
  Future<void> saveTheme(UserTheme theme) async {
    final settingsWrapper = await _getSettings();

    await _isar.writeTxn(() async {
      await _isar.settings.put(
        settingsWrapper.copyWithTheme(theme),
      );
    });
  }

  @override
  Future<List<MangaContentRating>> getContentRating() async {
    final settingsWrapper = await _getSettings();
    return SettingsHelper.ratingsFromSettings(settingsWrapper);
  }

  @override
  Future<void> setContentRating(List<MangaContentRating> ratings) async {
    final settingsWrapper = await _getSettings();

    await _isar.writeTxn(() async {
      await _isar.settings.put(
        settingsWrapper.copyWithRatings(ratings),
      );
    });
  }

  void dispose() {
    _authStateSub.cancel();
  }
}

FutureOr disposeCombinedSettingsRepository(SettingsRepository repository) async {
  if (repository is CombinedSettingsRepository) {
    repository.dispose();
  }
}
