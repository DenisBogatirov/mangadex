// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/use_cases/get_content_rating_stream.use_case.dart';
import 'package:mangadex/settings/domain/use_cases/set_content_rating.use_case.dart';

part 'drawer_content_rating_state.dart';

@singleton
class MangaContentRatingCubit extends Cubit<MangaContentRatingState> {
  final GetContentRatingStreamUseCase _getContentRatingStreamUseCase;
  final SetContentRatingUseCase _setContentRatingUseCase;
  late final StreamSubscription<List<MangaContentRating>> _ratingsSub;

  MangaContentRatingCubit(this._getContentRatingStreamUseCase, this._setContentRatingUseCase)
      : super(MangaContentRatingLoading()) {
    _ratingsSub = _getContentRatingStreamUseCase(_onRatingsChange);
  }

  void _onRatingsChange(List<MangaContentRating> ratings) async {
    emit(
      MangaContentRatingReady(ratings: ratings),
    );
  }

  Future<void> changeRatings(List<MangaContentRating> ratings) async {
    await _setContentRatingUseCase(ratings);
    emit(
      MangaContentRatingReady(ratings: ratings),
    );
  }

  @override
  Future<void> close() {
    _ratingsSub.cancel();
    return super.close();
  }
}
