// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:mangadex/auth/api/dto/sign_in.dto.dart';
import 'package:mangadex/infrastructure/api_client/mangadex_dio.dart';

part 'auth_client.g.dart';

@LazySingleton()
@RestApi()
abstract class AuthClient {
  @factoryMethod
  factory AuthClient(MangaDexDio dio) = _AuthClient;

  @POST('/auth/login')
  Future<UserTokenResponseDTO> signIn(@Body() SignInDTO dto);
}
