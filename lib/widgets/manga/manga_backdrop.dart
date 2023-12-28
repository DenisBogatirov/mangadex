// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';

class MangaBackdrop extends StatefulWidget {
  final Manga manga;

  const MangaBackdrop({
    super.key,
    required this.manga,
  });

  @override
  State<MangaBackdrop> createState() => _MangaBackdropState();
}

class _MangaBackdropState extends State<MangaBackdrop> with AutomaticKeepAliveClientMixin<MangaBackdrop> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CachedNetworkImage(
      imageUrl: widget.manga.coverArt,
      fit: BoxFit.cover,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
