// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga_tag.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'manga_tag_chip.dart';

class MangaTags extends StatelessWidget {
  final Manga manga;

  const MangaTags({
    super.key,
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    final tags = manga.tags
        .where((tag) => ![MangaTagGroup.theme, MangaTagGroup.format].contains(tag.group))
        .sorted((a, b) => a.name.values.first.compareTo(b.name.values.first));

    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        if (manga.contentRating != MangaContentRating.safe) ...{
          MangaTagChip.contentRating(manga.contentRating),
        },
        for (final tag in tags) MangaTagChip(tag.name.values.first)
      ],
    );
  }
}
