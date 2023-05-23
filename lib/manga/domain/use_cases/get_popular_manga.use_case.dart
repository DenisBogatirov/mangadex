// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga.repository.dart';
import 'package:mangadex/settings/domain/use_cases/get_content_rating.use_case.dart';
import 'package:mangadex/utils/relationship_type.dart';

@injectable
class GetPopularMangaUseCase {
  final MangaRepository _mangaRepository;
  final GetContentRatingUseCase _getContentRatingUseCase;

  GetPopularMangaUseCase(this._mangaRepository, this._getContentRatingUseCase);

  Future<List<Manga>> call() async {
    final now = DateTime.now();
    final currentMonthDaysCount = DateTime(now.year, now.month, 0).day;
    final oneMonthAgo = now.subtract(Duration(days: currentMonthDaysCount));
    final contentRatings = await _getContentRatingUseCase();

    return _mangaRepository.fetchManga(
      includes: [RelationshipType.author, RelationshipType.artist, RelationshipType.coverArt],
      contentRating: contentRatings,
      hasAvailableChapters: true,
      createdAtSince: oneMonthAgo,
    );
  }
}
