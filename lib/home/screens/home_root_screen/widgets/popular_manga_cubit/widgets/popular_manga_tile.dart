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
import 'package:mangadex/widgets/media_query_builder.dart';

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
      fallback: (context) => _PopularMangaTitleMobile(
        manga: widget.manga,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PopularMangaTitleMobile extends StatelessWidget {
  final Manga manga;

  const _PopularMangaTitleMobile({required this.manga});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(imageUrl: manga.coverArt, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl: manga.coverArt256,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(),
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // TODO: Adjust with content language
                          manga.title.entries.first.value,
                          maxLines: 3,
                          style:
                              context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          [...manga.authors, ...manga.artists].map((c) => c.name).toSet().join(', '),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
