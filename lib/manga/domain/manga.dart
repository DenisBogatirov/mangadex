// Dart imports:
import 'dart:ui';

// Project imports:
import 'creator.dart';
import 'manga_tag.dart';

enum MangaStatus {
  ongoing,
  completed,
  hiatus,
  cancelled,
}

enum MangaContentRating {
  safe,
  suggestive,
  erotica,
  pornographic,
}

enum MangaPublicationDemographic {
  shounen,
  shoujo,
  josei,
  seinen,
}

class Manga {
  final String id;
  final Map<Locale, String> _titles;
  final Map<Locale, String> _descriptions;
  // TODO: Create separate class
  final List<Map<Locale, String>> _altTitles;
  final Locale originalLanguage;
  final bool isLocked;

  // TODO: Create model
  final Map<String, String> links;

  final String lastVolume;
  final String lastChapter;
  final int? year;
  final MangaStatus status;
  final MangaContentRating contentRating;
  final MangaPublicationDemographic? publicationDemographic;
  final bool chapterNumbersResetOnNewVolume;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String latestUploadedChapter;
  final List<Locale> availableTranslatedLanguages;
  final List<MangaTag> tags;
  final List<Author> authors;
  final List<Artist> artists;
  final String coverArt;

  const Manga({
    required this.id,
    required this.originalLanguage,
    required this.isLocked,
    required this.links,
    required this.lastVolume,
    required this.lastChapter,
    required this.status,
    required this.contentRating,
    required this.chapterNumbersResetOnNewVolume,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.latestUploadedChapter,
    required this.availableTranslatedLanguages,
    required this.authors,
    required this.artists,
    required this.tags,
    required this.coverArt,
    this.publicationDemographic,
    this.year,
    required Map<Locale, String> titles,
    required Map<Locale, String> descriptions,
    required List<Map<Locale, String>> altTitles,
  })  : _titles = titles,
        _descriptions = descriptions,
        _altTitles = altTitles;
}
