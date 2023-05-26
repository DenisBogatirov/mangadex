// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/utils/cover_art_extension.dart';
import 'package:mangadex/widgets/manga/manga_cover_art.dart';
import 'package:mangadex/widgets/manga/manga_creator_row.dart';
import 'package:mangadex/widgets/manga/manga_description.dart';
import 'package:mangadex/widgets/manga/manga_tags.dart';
import 'package:mangadex/widgets/manga/manga_title.dart';
import 'package:mangadex/widgets/media_query_builder.dart';

part 'mobile_popular_manga_tile.dart';
part 'tablet_popular_manga_tile.dart';
part 'desktop_popular_manga_tile.dart';

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
      desktop: (context) => _PopularMangaTitleDesktop(manga: widget.manga),
      tablet: (context) => _PopularMangaTitleTablet(manga: widget.manga),
      mobile: (context) => _PopularMangaTitleMobile(manga: widget.manga),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
