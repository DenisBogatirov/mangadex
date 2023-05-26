// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';

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
