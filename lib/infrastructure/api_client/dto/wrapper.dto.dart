// Package imports:
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/manga/api/dto/cover_art.dto.dart';
import 'package:mangadex/manga/api/dto/creator.dto.dart';
import 'package:mangadex/manga/api/dto/manga.dto.dart';
import 'package:mangadex/manga/api/dto/manga_tag.dto.dart';
import 'package:mangadex/user/api/dto/user.dto.dart';
import 'package:mangadex/utils/relationship_type.dart';

enum ResponseType {
  collection,
  entity,
}

abstract class ResponseWrapperDTO {
  final String result;

  ResponseWrapperDTO({required this.result});
}

abstract class DataResponseWrapperDTO<T extends DataResponseDTO> extends ResponseWrapperDTO {
  final ResponseType response;
  final T data;

  DataResponseWrapperDTO({
    required super.result,
    required this.response,
    required this.data,
  });
}

abstract class CollectionResponseWrapperDTO<T extends DataResponseDTO> extends ResponseWrapperDTO {
  final ResponseType response;
  final List<T> data;

  CollectionResponseWrapperDTO({
    required super.result,
    required this.response,
    required this.data,
  });
}

abstract class DataResponseDTO<T> {
  final String id;

  @RelationshipTypeConverter()
  final RelationshipType type;

  final T? attributes;

  @JsonKey(fromJson: attributesFromJson)
  final List<DataResponseDTO>? relationships;

  const DataResponseDTO({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  static List<DataResponseDTO>? attributesFromJson<T extends DataResponseDTO>(Object? relationships) {
    if (relationships == null) return null;

    final result = <DataResponseDTO>[];
    for (final json in (relationships as List)) {
      final RelationshipType? type = RelationshipType.values.firstWhereOrNull(
            (t) => t.value == json['type'],
      );
      if (type != null) {
        switch (type) {
          case RelationshipType.author:
            result.add(AuthorDataDTO.fromJson(json));
            break;
          case RelationshipType.artist:
            result.add(ArtistDataDTO.fromJson(json));
            break;
          case RelationshipType.tag:
            result.add(MangaTagDataDTO.fromJson(json));
            break;
          case RelationshipType.coverArt:
            result.add(CoverArtDataDTO.fromJson(json));
            break;
          case RelationshipType.user:
            result.add(UserDataDTO.fromJson(json));
            break;
          case RelationshipType.manga:
            result.add(MangaDataDTO.fromJson(json));
            break;
          case RelationshipType.chapter:
          case RelationshipType.scanlationGroup:
          case RelationshipType.customList:
          default:
            throw UnimplementedError();
        }
      }
    }
    return result;
  }
}
