part of 'popular_manga_tile.dart';

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
                  MobileMangaCoverArtImage(url: manga.coverArt256),
                  const VerticalDivider(),
                  Flexible(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MangaTitle(manga: manga),
                        MangaCreatorsRow(manga: manga),
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
