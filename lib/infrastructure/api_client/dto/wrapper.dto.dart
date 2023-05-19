// Package imports:
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:mangadex/manga/api/dto/author.dto.dart';
import 'package:mangadex/manga/api/dto/cover_art.dto.dart';
import 'package:mangadex/manga/api/dto/manga.dto.dart';
import 'package:mangadex/manga/api/dto/manga_tag.dto.dart';
import 'package:mangadex/user/api/dto/user.dto.dart';

enum ResponseType {
  collection,
  entity,
}

@JsonEnum(valueField: 'value')
enum DataResponseType {
  manga('manga'),
  chapter('chapter'),
  coverArt('cover_art'),
  author('author'),
  artist('artist'),
  scanlationGroup('scanlation_group'),
  tag('tag'),
  user('user'),
  customList('custom_list');

  final String value;

  const DataResponseType(this.value);
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
  final DataResponseType type;
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
      final DataResponseType? type = DataResponseType.values.firstWhereOrNull(
            (t) => t.value == json['type'],
      );
      if (type != null) {
        switch (type) {
          case DataResponseType.author:
            result.add(AuthorDataDTO.fromJson(json));
            break;
          case DataResponseType.artist:
            result.add(AuthorDataDTO.fromJson(json));
            break;
          case DataResponseType.tag:
            result.add(MangaTagDataDTO.fromJson(json));
            break;
          case DataResponseType.coverArt:
            result.add(CoverArtDataDTO.fromJson(json));
            break;
          case DataResponseType.user:
            result.add(UserDataDTO.fromJson(json));
            break;
          case DataResponseType.manga:
            result.add(MangaDataDTO.fromJson(json));
            break;
          case DataResponseType.chapter:
          case DataResponseType.scanlationGroup:
          case DataResponseType.customList:
          default:
            throw UnimplementedError();
        }
      }
    }
    return result;
  }
}
