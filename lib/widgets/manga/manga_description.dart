// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/manga/domain/manga.dart';

class MangaDescription extends StatelessWidget {
  final Manga manga;

  const MangaDescription({
    super.key,
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    if (manga.description.isEmpty) {
      return const SizedBox.shrink();
    }

    return Scrollbar(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Text(
          // TODO: Adjust with content language
          manga.description.entries.first.value,
        ),
      ),
    );
  }
}
