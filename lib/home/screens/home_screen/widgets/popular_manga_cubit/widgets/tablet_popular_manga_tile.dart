part of 'popular_manga_tile.dart';

class _PopularMangaTitleTablet extends StatelessWidget {
  final Manga manga;

  const _PopularMangaTitleTablet({
    required this.manga,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.accentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabletMangaCoverArtImage(url: manga.coverArt256),
            const VerticalDivider(),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: DividerTheme(
                  data: context.theme.dividerTheme.copyWith(
                    space: context.theme.dividerTheme.space! / 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MangaTitle(manga: manga),
                      const Divider(),
                      MangaTags(manga: manga),
                      const Divider(),
                      MangaCreatorsRow(manga: manga, italic: true),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
