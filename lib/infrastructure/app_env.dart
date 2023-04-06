// Package imports:
import 'package:injectable/injectable.dart';

class AppEnv {
  final String name;

  final String baseApiUrl;

  const AppEnv(
      this.name, {
        required this.baseApiUrl,
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
  );
}

