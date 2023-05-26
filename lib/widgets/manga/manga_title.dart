// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/manga/domain/manga.dart';

class MangaTitle extends StatelessWidget {
  final Manga manga;
  final int maxLines;

  const MangaTitle({
    super.key,
    required this.manga,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      // TODO: Adjust with content language
      manga.title.entries.first.value,
      maxLines: maxLines,
      style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
      overflow: TextOverflow.ellipsis,
    );
  }
}
