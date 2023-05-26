// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
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
    return Stack(
      children: [
        Positioned.fill(child: CachedNetworkImage(imageUrl: widget.manga.coverArt, fit: BoxFit.cover)),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.theme.colorScheme.background,
                    context.theme.colorScheme.background.withOpacity(0.5),
                    context.theme.colorScheme.background.withOpacity(0.5),
                    context.theme.colorScheme.background,
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
