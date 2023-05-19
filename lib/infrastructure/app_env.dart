// Package imports:
import 'package:injectable/injectable.dart';

class AppEnv {
  final String name;

  final String baseApiUrl;
  final String uploadsApiUrl;

  const AppEnv(
      this.name, {
        required this.baseApiUrl,
        required this.uploadsApiUrl,
      });
}

const aDevName = 'a_dev';

const aDev = Environment(aDevName);

@module
abstract class EnvModule {
  @lazySingleton
  AppEnv get env => const AppEnv(
    aDevName,
    baseApiUrl: 'https://api.mangadex.org',
    uploadsApiUrl: 'https://uploads.mangadex.org/',
  );
}

