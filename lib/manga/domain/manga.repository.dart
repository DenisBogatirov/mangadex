// Project imports:
import 'manga.dart';

abstract interface class MangaRepository {
  Future<List<Manga>> fetchPopularManga();
}
