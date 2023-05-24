// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/mangadex_dio.dart';
import 'package:mangadex/settings/api/dto/settings.dto.dart';

part 'settings.client.g.dart';

@LazySingleton()
@RestApi()
abstract class SettingsClient {
  @factoryMethod
  factory SettingsClient(AuthorizedMangaDexDio dio) = _SettingsClient;

  @GET('/settings')
  Future<SettingsWrapperDTO> getSettings();
}
