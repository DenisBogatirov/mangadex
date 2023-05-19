import 'dart:ui';

enum MangaTagGroup {
  theme,
  genre,
  format,
}

class MangaTag {
  final String id;
  final Map<Locale, String> _names;
  final Map<Locale, String> _descriptions;
  final MangaTagGroup group;

  const MangaTag({
    required this.id,
    required this.group,
    required Map<Locale, String> names,
    required Map<Locale, String> descriptions,
  })  : _names = names,
        _descriptions = descriptions;
}
