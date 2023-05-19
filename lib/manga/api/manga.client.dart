// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

// Project imports:
import 'package:mangadex/infrastructure/api_client/mangadex_dio.dart';
import 'package:mangadex/manga/api/dto/manga.dto.dart';

part 'manga.client.g.dart';

@LazySingleton()
@RestApi()
abstract class MangaClient {
  @factoryMethod
  factory MangaClient(MangaDexDio dio) = _MangaClient;

  @GET('/manga')
  Future<MangaListResponseDTO> fetchManga({
    @Query('includes[]') List<String>? includes,
    @Query('contentRating[]') List<String>? contentRating,
    @Query('hasAvailableChapters') bool? hasAvailableChapters,
    @Query('order[followedCount]') String order = 'desc',
    @Query('createdAtSince') String? createdAtSince,
  });
}
