// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/settings/domain/use_cases/get_content_rating.use_case.dart';
import 'package:mangadex/settings/domain/use_cases/set_content_rating.use_case.dart';

part 'drawer_content_rating_state.dart';

@singleton
class MangaContentRatingCubit extends Cubit<MangaContentRatingState> {
  final GetContentRatingUseCase _getContentRatingUseCase;
  final SetContentRatingUseCase _setContentRatingUseCase;

  MangaContentRatingCubit(this._getContentRatingUseCase, this._setContentRatingUseCase)
      : super(MangaContentRatingLoading()) {
    _init();
  }

  Future<void> _init() async {
    final ratings = await _getContentRatingUseCase();
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
}
