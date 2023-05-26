// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/manga/domain/manga.dart';

class MangaCreatorsRow extends StatelessWidget {
  final Manga manga;
  final bool italic;

  const MangaCreatorsRow({
    super.key,
    required this.manga,
    this.italic = false,
  });

  @override
  Widget build(BuildContext context) {
    return
      Text(
        [...manga.authors, ...manga.artists].map((c) => c.name).toSet().join(', '),
        overflow: TextOverflow.ellipsis,
        style: context.theme.textTheme.bodyMedium?.copyWith(
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        ),
      );
  }
}
