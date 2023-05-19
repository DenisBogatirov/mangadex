// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/api/manga.client.dart';
import 'package:mangadex/manga/api/manga.mapper.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga.repository.dart';

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
  Future<List<Manga>> fetchPopularManga() async {
    final now = DateTime.now();
    final dtos = await _mangaClient.fetchManga(
      includes: ['author', 'artist', 'cover_art'],
      // TODO: Get from settings
      contentRating: ['safe', 'suggestive'],
      hasAvailableChapters: true,
      createdAtSince: now
          .subtract(Duration(days: DateTime(now.year, now.month, 0).day))
          .toUtc()
          .toIso8601String()
          .replaceAll(RegExp(r'\..*'), ''),
    );

    return dtos.data.map((dto) => _mangaMapper.toManga(dto)).toList();
  }
}
