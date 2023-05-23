// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/api/manga.client.dart';
import 'package:mangadex/manga/api/manga.mapper.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga.repository.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/utils/relationship_type.dart';

@Singleton(as: MangaRepository)
class HttpMangaRepository implements MangaRepository {
  final MangaClient _mangaClient;
  final MangaMapper _mangaMapper;

  const HttpMangaRepository({
    required MangaClient mangaClient,
    required MangaMapper mangaMapper,
  })  : _mangaClient = mangaClient,
        _mangaMapper = mangaMapper;

  @override
  Future<List<Manga>> fetchManga({
    List<RelationshipType> includes = const [],
    List<MangaContentRating> contentRating = const [],
    bool hasAvailableChapters = true,
    DateTime? createdAtSince,
  }) async {
    final dtos = await _mangaClient.fetchManga(
      includes: [for (final type in includes) type.value],
      contentRating: [for (final rating in contentRating) rating.name],
      hasAvailableChapters: hasAvailableChapters,
      createdAtSince: createdAtSince?.toUtc().toIso8601String().replaceAll(RegExp(r'\..*'), ''),
    );

    return dtos.data.map((dto) => _mangaMapper.toManga(dto)).toList();
  }
}
