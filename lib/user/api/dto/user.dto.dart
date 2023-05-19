// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';
import 'package:mangadex/user/domain/user.dart';

part 'user.dto.g.dart';

@JsonSerializable(createToJson: false)
class UserResponseDTO extends DataResponseWrapperDTO<UserDataDTO> {
  UserResponseDTO({
    required super.result,
    required super.response,
    required super.data,
  });

  factory UserResponseDTO.fromJson(Map<String, dynamic> json) => _$UserResponseDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserDataDTO extends DataResponseDTO<UserDTO> {
  @override
  UserDTO get attributes => super.attributes!;

  UserDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory UserDataDTO.fromJson(Map<String, dynamic> json) => _$UserDataDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class UserDTO {
  final String username;
  final List<UserRole> roles;

  UserDTO({
    required this.username,
    required this.roles,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
}
