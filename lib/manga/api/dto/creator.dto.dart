// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/dto/wrapper.dto.dart';
import 'package:mangadex/utils/relationship_type.dart';

part 'creator.dto.g.dart';

abstract class CreatorDTO {
  final String name;
  final String? imageUrl;
  final Map<String, String> biography;
  final String? twitter;
  final String? pixiv;
  final String? melonBook;
  final String? fanBox;
  final String? booth;
  final String? nicoVideo;
  final String? skeb;
  final String? fantia;
  final String? tumblr;
  final String? youtube;
  final String? weibo;
  final String? naver;
  final String? website;
  final String createdAt;
  final String updatedAt;
  final int version;

  const CreatorDTO({
    required this.name,
    this.imageUrl,
    required this.biography,
    this.twitter,
    this.pixiv,
    this.melonBook,
    this.fanBox,
    this.booth,
    this.nicoVideo,
    this.skeb,
    this.fantia,
    this.tumblr,
    this.youtube,
    this.weibo,
    this.naver,
    this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
}

@JsonSerializable(createToJson: false)
class AuthorDTO extends CreatorDTO {
  AuthorDTO({
    required super.name,
    super.imageUrl,
    required super.biography,
    super.twitter,
    super.pixiv,
    super.melonBook,
    super.fanBox,
    super.booth,
    super.nicoVideo,
    super.skeb,
    super.fantia,
    super.tumblr,
    super.youtube,
    super.weibo,
    super.naver,
    super.website,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory AuthorDTO.fromJson(Map<String, dynamic> json) => _$AuthorDTOFromJson(json);
}

@JsonSerializable(createToJson: false)
class ArtistDTO extends CreatorDTO {
  ArtistDTO({
    required super.name,
    super.imageUrl,
    required super.biography,
    super.twitter,
    super.pixiv,
    super.melonBook,
    super.fanBox,
    super.booth,
    super.nicoVideo,
    super.skeb,
    super.fantia,
    super.tumblr,
    super.youtube,
    super.weibo,
    super.naver,
    super.website,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory ArtistDTO.fromJson(Map<String, dynamic> json) => _$ArtistDTOFromJson(json);
}

@RelationshipTypeConverter()
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

@RelationshipTypeConverter()
@JsonSerializable(createToJson: false)
class ArtistDataDTO extends DataResponseDTO<ArtistDTO> {
  ArtistDataDTO({
    required super.id,
    required super.type,
    required super.attributes,
    required super.relationships,
  });

  factory ArtistDataDTO.fromJson(Map<String, dynamic> json) => _$ArtistDataDTOFromJson(json);
}
