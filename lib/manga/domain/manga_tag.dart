import 'dart:ui';

import 'package:equatable/equatable.dart';

enum MangaTagGroup {
  theme,
  genre,
  format,
}

class MangaTag extends Equatable {
  final String id;
  final Map<Locale, String> name;
  final Map<Locale, String> description;
  final MangaTagGroup group;

  const MangaTag({
    required this.id,
    required this.group,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id];
}
