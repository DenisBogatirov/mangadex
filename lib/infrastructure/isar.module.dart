// Package imports:
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// Project imports:
import 'package:mangadex/settings/api/dto/settings.dto.dart';

@module
abstract class RegisterModule {
  @singleton
  @preResolve
  Future<Isar> get isar async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    return Isar.open(
      [SettingsWrapperDTOSchema],
      directory: dir.path,
    );
  }
}
