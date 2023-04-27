// Package imports:
import 'package:json_annotation/json_annotation.dart';

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

  ResponseWrapperDTO({ required this.result });
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

abstract class DataResponseDTO<T> {
  final String id;
  final DataResponseType type;
  final T attributes;
  // final List<DataResponseDTO> relations;

  const DataResponseDTO({
    required this.id,
    required this.type,
    required this.attributes,
    // required this.relations,
  });
}
