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
                        Text(
                          // TODO: Adjust with content language
                          manga.title.entries.first.value,
                          maxLines: 3,
                          style:
                              context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          [...manga.authors, ...manga.artists].map((c) => c.name).toSet().join(', '),
                          overflow: TextOverflow.ellipsis,
                        ),
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

class MobileMangaCoverArtImage extends StatelessWidget {
  final String url;

  const MobileMangaCoverArtImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 128,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          progressIndicatorBuilder: (context, url, progress) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
