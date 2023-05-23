// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/use_cases/get_popular_manga.use_case.dart';
import 'package:mangadex/settings/drawers/user_drawer_content_rating/drawer_content_rating_cubit.dart';

part 'popular_manga_state.dart';

@injectable
class PopularMangaCubit extends Cubit<PopularMangaState> {
  final GetPopularMangaUseCase _getPopularMangaUseCase;
  late final StreamSubscription _contentRatingSubscription;

  PopularMangaCubit(this._getPopularMangaUseCase) : super(PopularMangaLoading()) {
    fetchPopularManga();
  }

  void subscribeToContentRating(MangaContentRatingCubit mangaContentRatingCubit) {
    _contentRatingSubscription = mangaContentRatingCubit.stream.listen(_onRatingChange);
  }

  void _onRatingChange(_) {
    fetchPopularManga();
  }

  Future<void> fetchPopularManga() async {
    emit(
      PopularMangaReady(
        manga: await _getPopularMangaUseCase(),
      ),
    );
  }

  @override
  Future<void> close() async {
    _contentRatingSubscription.cancel();
    super.close();
  }
}
