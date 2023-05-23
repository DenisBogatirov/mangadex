// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/settings/domain/content_rating.dart';

extension MangaContentRatingTranslationExtension on MangaContentRating {
  String tr() => '${LocaleKeys.contentRating}.$name'.tr();
}
