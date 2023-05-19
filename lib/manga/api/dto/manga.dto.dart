// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/utils/relationship_type.dart';
import 'manga_tag.dto.dart';

part 'manga.dto.g.dart';

@JsonSerializable(createToJson: false)
class MangaListResponseDTO extends CollectionResponseWrapperDTO<MangaDataDTO> {
  MangaListResponseDTO({
    required super.result,
    required super.response,
    required super.data,
  });

  factory MangaListResponseDTO.fromJson(Map<String, dynamic> json) => _$MangaListResponseDTOFromJson(json);
}

@RelationshipTypeConverter()
@JsonSerializable(createToJson: false)
class MangaDataDTO extends DataResponseDTO<MangaDTO> {
  MangaDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory MangaDataDTO.fromJson(Map<String, dynamic> json) => _$MangaDataDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class MangaDTO {
  final Map<String, String> title;
  final List<Map<String, String>> altTitles;
  final Map<String, String> description;
  final bool isLocked;

  // TODO: Create proper model
  final Map<String, String> links;
  final String originalLanguage;
  final String lastVolume;
  final String lastChapter;
  final MangaPublicationDemographic? publicationDemographic;
  final MangaStatus status;
  final int? year;
  final MangaContentRating contentRating;
  final List<MangaTagDataDTO> tags;
  final String state;
  final bool chapterNumbersResetOnNewVolume;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final List<String> availableTranslatedLanguages;
  final String latestUploadedChapter;

  const MangaDTO({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.isLocked,
    required this.links,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    this.publicationDemographic,
    required this.status,
    this.year,
    required this.contentRating,
    required this.tags,
    required this.state,
    required this.chapterNumbersResetOnNewVolume,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.availableTranslatedLanguages,
    required this.latestUploadedChapter,
  });

  factory MangaDTO.fromJson(Map<String, dynamic> json) => _$MangaDTOFromJson(json);
}
