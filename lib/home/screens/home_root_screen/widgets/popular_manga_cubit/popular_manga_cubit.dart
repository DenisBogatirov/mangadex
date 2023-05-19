// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/use_cases/get_popular_manga.use_case.dart';

part 'popular_manga_state.dart';

@injectable
class PopularMangaCubit extends Cubit<PopularMangaState> {
  final GetPopularMangaUseCase _getPopularMangaUseCase;

  PopularMangaCubit(this._getPopularMangaUseCase) : super(PopularMangaLoading()) {
    fetchPopularManga();
  }

  Future<void> fetchPopularManga() async {
    emit(
      PopularMangaReady(
        manga: await _getPopularMangaUseCase(),
      ),
    );
  }
}
