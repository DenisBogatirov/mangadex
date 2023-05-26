// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/manga/domain/manga.dart';
import 'manga_tag_chip.dart';

class MangaTags extends StatelessWidget {
  final Manga manga;

  const MangaTags({
    super.key,
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: [
        MangaTagChip.contentRating(manga.contentRating),
        for (final tag in manga.tags) MangaTagChip(tag.name.values.first)
      ],
    );
  }
}
