// Package imports:
import 'package:json_annotation/json_annotation.dart';

enum RelationshipType {
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

  const RelationshipType(this.value);
}

class RelationshipTypeConverter implements JsonConverter<RelationshipType, String> {
  const RelationshipTypeConverter();

  @override
  RelationshipType fromJson(String json) => RelationshipType.values.firstWhere((element) => element.value == json);

  @override
  String toJson(RelationshipType object) => object.value;
}
