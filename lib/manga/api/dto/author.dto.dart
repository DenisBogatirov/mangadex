// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';
import 'package:mangadex/manga/domain/author.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga_tag.dart';

part 'author.dto.g.dart';

@JsonSerializable(createToJson: false)
class AuthorDataDTO extends DataResponseDTO<AuthorDTO> {
  AuthorDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory AuthorDataDTO.fromJson(Map<String, dynamic> json) => _$AuthorDataDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class AuthorDTO {
  final String name;

  AuthorDTO(this.name);

  factory AuthorDTO.fromJson(Map<String, dynamic> json) => _$AuthorDTOFromJson(json);
}
