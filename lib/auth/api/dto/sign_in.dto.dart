// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';

part 'sign_in.dto.g.dart';

@JsonSerializable(createFactory: false)
class SignInDTO {
  final String username;
  final String password;

  SignInDTO(this.username, this.password);

  SignInDTO.fromPayload(UsernamePayload payload)
      : username = payload.username,
        password = payload.password;

  Map<String, dynamic> toJson() => _$SignInDTOToJson(this);
}

@JsonSerializable(createToJson: false)
class UserTokenResponseDTO extends ResponseWrapperDTO {
  final TokenDTO token;

  UserTokenResponseDTO(super.result, this.token);

  factory UserTokenResponseDTO.fromJson(Map<String, dynamic> json) => _$UserTokenResponseDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class TokenDTO {
  final String session;
  final String refresh;


  TokenDTO(this.session, this.refresh);

  factory TokenDTO.fromJson(Map<String, dynamic> json) => _$TokenDTOFromJson(json);
}
