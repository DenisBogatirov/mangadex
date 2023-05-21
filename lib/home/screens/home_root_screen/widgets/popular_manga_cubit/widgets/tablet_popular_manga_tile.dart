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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // TODO: Adjust with content language
                      manga.title.entries.first.value,
                      maxLines: 3,
                      style: context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Wrap(
                      spacing: 10,
                      children: [
                        MangaTagChip.contentRating(manga.contentRating),
                        for (final tag in manga.tags) MangaTagChip(tag.name.values.first)
                      ],
                    ),
                    Text(
                      [...manga.authors, ...manga.artists].map((c) => c.name).toSet().join(', '),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabletMangaCoverArtImage extends StatelessWidget {
  final String url;

  const TabletMangaCoverArtImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 128,
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: double.infinity,
            progressIndicatorBuilder: (context, url, progress) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
