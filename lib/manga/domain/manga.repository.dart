// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/utils/relationship_type.dart';
import 'manga.dart';

abstract interface class MangaRepository {
  Future<List<Manga>> fetchManga({
    List<RelationshipType> includes = const [],
    List<MangaContentRating> contentRating = const [],
    bool hasAvailableChapters = true,
    DateTime? createdAtSince,
  });
}
