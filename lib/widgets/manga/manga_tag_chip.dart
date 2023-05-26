// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/settings/domain/content_rating.dart';
import 'package:mangadex/utils/manga_content_rating_extension.dart';

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
