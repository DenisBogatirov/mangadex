// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';

part 'cover_art.dto.g.dart';

@JsonSerializable(createToJson: false)
class CoverArtDataDTO extends DataResponseDTO<CoverArtDTO> {
  CoverArtDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory CoverArtDataDTO.fromJson(Map<String, dynamic> json) => _$CoverArtDataDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class CoverArtDTO {
  final String description;
  final String? volume;
  final String fileName;
  final String locale;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  factory CoverArtDTO.fromJson(Map<String, dynamic> json) => _$CoverArtDTOFromJson(json);

  const CoverArtDTO({
    required this.description,
    this.volume,
    required this.fileName,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
}
