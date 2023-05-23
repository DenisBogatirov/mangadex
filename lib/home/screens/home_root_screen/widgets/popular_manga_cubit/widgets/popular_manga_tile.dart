// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/utils/cover_art_extension.dart';
import 'package:mangadex/utils/manga_content_rating_extension.dart';
import 'package:mangadex/widgets/media_query_builder.dart';

part 'mobile_popular_manga_tile.dart';

part 'tablet_popular_manga_tile.dart';

class PopularMangaTile extends StatefulWidget {
  final Manga manga;

  const PopularMangaTile({
    super.key,
    required this.manga,
  });

  @override
  State<PopularMangaTile> createState() => _PopularMangaTileState();
}

class _PopularMangaTileState extends State<PopularMangaTile> with AutomaticKeepAliveClientMixin<PopularMangaTile> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MediaQueryBuilder(
      stops: {
        640: (context) => _PopularMangaTitleTablet(manga: widget.manga),
      },
      fallback: (context) => _PopularMangaTitleMobile(manga: widget.manga),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MangaTagChip extends StatelessWidget {
  final String text;
  final Color? color;

  const MangaTagChip(
    this.text, {
    super.key,
    this.color,
  });

  static statusYellow(String text) => MangaTagChip(text, color: MangaDexColors.statusYellow);

  static statusRed(String text) => MangaTagChip(text, color: MangaDexColors.statusRed);

  static contentRating(MangaContentRating rating) {
    final text = rating.tr();
    switch (rating) {
      case MangaContentRating.suggestive:
        return statusYellow(text);
      case MangaContentRating.erotica:
      case MangaContentRating.pornographic:
        return statusRed(text);
      case MangaContentRating.safe:
      default:
        return MangaTagChip(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.theme.colorScheme.accentColor;

    return Container(
      padding: const EdgeInsets.only(left: 8, right: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(
        text.toUpperCase(),
        style: context.theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
