// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';
import 'package:mangadex/manga/domain/manga_tag.dart';

part 'manga_tag.dto.g.dart';

@JsonSerializable(createToJson: false)
class MangaTagDataDTO extends DataResponseDTO<MangaTagDTO> {
  MangaTagDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory MangaTagDataDTO.fromJson(Map<String, dynamic> json) => _$MangaTagDataDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class MangaTagDTO {
  final Map<String, String> name;
  final Map<String, String> description;
  final MangaTagGroup group;

  MangaTagDTO(this.name, this.description, this.group);

  factory MangaTagDTO.fromJson(Map<String, dynamic> json) => _$MangaTagDTOFromJson(json);
}
