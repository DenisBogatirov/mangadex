// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/mangadex_dio.dart';
import 'dto/user.dto.dart';

part 'user.client.g.dart';

@LazySingleton()
@RestApi()
abstract class UserClient {
  @factoryMethod
  factory UserClient(AuthorizedMangaDexDio dio) = _UserClient;

  @GET('/user/me')
  Future<UserResponseDTO> me({@Queries() IncludesQuery? includes});
}


@JsonSerializable(createFactory: false)
class IncludesQuery {
  @JsonKey(name: 'includes[]')
  final String includes;

  IncludesQuery(List<String> params) : includes = params.join(',');

  Map<String, dynamic> toJson() => _$IncludesQueryToJson(this);
}
