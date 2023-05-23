part of 'drawer_content_rating_cubit.dart';

@immutable
sealed class MangaContentRatingState extends Equatable {
  const MangaContentRatingState();
}

class MangaContentRatingLoading extends MangaContentRatingState {
  @override
  List<Object?> get props => [];

}

class MangaContentRatingReady extends MangaContentRatingState {
  final List<MangaContentRating> ratings;

  const MangaContentRatingReady({
    required this.ratings,
  });

  @override
  List<Object?> get props => [ratings];
}
