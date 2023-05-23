// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga.repository.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/utils/relationship_type.dart';

@injectable
class GetPopularMangaUseCase {
  final MangaRepository _mangaRepository;

  GetPopularMangaUseCase(this._mangaRepository);

  Future<List<Manga>> call() async {
    final now = DateTime.now();
    final currentMonthDaysCount = DateTime(now.year, now.month, 0).day;
    final oneMonthAgo = now.subtract(Duration(days: currentMonthDaysCount));

    return _mangaRepository.fetchManga(
      includes: [RelationshipType.author, RelationshipType.artist, RelationshipType.coverArt],
      //TODO: Get from settings
      contentRating: [MangaContentRating.safe, MangaContentRating.suggestive],
      hasAvailableChapters: true,
      createdAtSince: oneMonthAgo,
    );
  }
}
