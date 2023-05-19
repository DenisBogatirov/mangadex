part of 'popular_manga_cubit.dart';

sealed class PopularMangaState extends Equatable {
  const PopularMangaState();
}

class PopularMangaLoading extends PopularMangaState {
  @override
  List<Object> get props => [];
}

class PopularMangaReady extends PopularMangaState {
  final List<Manga> manga;

  const PopularMangaReady({
    required this.manga,
  });

  @override
  List<Object> get props => [manga];
}
