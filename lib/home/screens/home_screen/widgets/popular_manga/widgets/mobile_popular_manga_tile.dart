part of 'popular_manga_tile.dart';

class _PopularMangaTitleMobile extends StatelessWidget {
  final Manga manga;

  const _PopularMangaTitleMobile({required this.manga});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 64.0),
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
      ],
    );
  }
}
