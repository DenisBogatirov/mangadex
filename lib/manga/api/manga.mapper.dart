// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as path;

// Project imports:
import 'package:mangadex/infrastructure/app_env.dart';
import 'package:mangadex/manga/api/dto/cover_art.dto.dart';
import 'package:mangadex/manga/api/dto/creator.dto.dart';
import 'package:mangadex/manga/api/dto/manga.dto.dart';
import 'package:mangadex/manga/api/dto/manga_tag.dto.dart';
import 'package:mangadex/manga/domain/creator.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/manga/domain/manga_tag.dart';

@singleton
class MangaMapper {
  final CreatorMapper _authorMapper;
  final MangaTagMapper _mangaTagMapper;
  final CoverArtMapper _coverArtMapper;

  MangaMapper(this._authorMapper, this._mangaTagMapper, this._coverArtMapper);

  Manga toManga(MangaDataDTO dto) {
    final attributes = dto.attributes!;
    final relationships = dto.relationships!;

    return Manga(
      id: dto.id,
      originalLanguage: Locale.fromSubtags(languageCode: attributes.originalLanguage),
      isLocked: attributes.isLocked,
      links: attributes.links,
      lastVolume: attributes.lastVolume,
      lastChapter: attributes.lastChapter,
      year: attributes.year,
      status: attributes.status,
      contentRating: attributes.contentRating,
      publicationDemographic: attributes.publicationDemographic,
      chapterNumbersResetOnNewVolume: attributes.chapterNumbersResetOnNewVolume,
      createdAt: attributes.createdAt,
      updatedAt: attributes.updatedAt,
      version: attributes.version,
      latestUploadedChapter: attributes.latestUploadedChapter,
      availableTranslatedLanguages: [
        for (final languageCode in attributes.availableTranslatedLanguages)
          Locale.fromSubtags(languageCode: languageCode),
      ],
      authors: [
        for (final dto in relationships.whereType<AuthorDataDTO>()) _authorMapper.toAuthor(dto),
      ],
      artists: [
        for (final dto in relationships.whereType<ArtistDataDTO>()) _authorMapper.toArtist(dto),
      ],
      tags: [
        for (final dto in attributes.tags) _mangaTagMapper.toTag(dto),
      ],
      coverArt: _coverArtMapper.toCoverArtUrl(
        relationships.whereType<CoverArtDataDTO>().first,
        dto.id,
      ),
      title: {
        for (final entry in attributes.title.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
      description: {
        for (final entry in attributes.description.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
      altTitles: [
        for (final title in attributes.altTitles)
          {
            for (final entry in title.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
          }
      ],
    );
  }
}

@singleton
class CreatorMapper {
  Author toAuthor(AuthorDataDTO dto) {
    final attributes = dto.attributes!;

    return Author(
      id: dto.id,
      name: attributes.name,
      imageUrl: attributes.imageUrl,
      biography: {
        for (final entry in attributes.biography.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
      twitter: attributes.twitter,
      pixiv: attributes.pixiv,
      melonBook: attributes.melonBook,
      fanBox: attributes.fanBox,
      booth: attributes.booth,
      nicoVideo: attributes.nicoVideo,
      skeb: attributes.skeb,
      fantia: attributes.fantia,
      tumblr: attributes.tumblr,
      youtube: attributes.youtube,
      weibo: attributes.weibo,
      naver: attributes.naver,
      website: attributes.website,
      createdAt: attributes.createdAt,
      updatedAt: attributes.updatedAt,
      version: attributes.version,
    );
  }

  Artist toArtist(ArtistDataDTO dto) {
    final attributes = dto.attributes!;

    return Artist(
      id: dto.id,
      name: attributes.name,
      imageUrl: attributes.imageUrl,
      biography: {
        for (final entry in attributes.biography.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
      twitter: attributes.twitter,
      pixiv: attributes.pixiv,
      melonBook: attributes.melonBook,
      fanBox: attributes.fanBox,
      booth: attributes.booth,
      nicoVideo: attributes.nicoVideo,
      skeb: attributes.skeb,
      fantia: attributes.fantia,
      tumblr: attributes.tumblr,
      youtube: attributes.youtube,
      weibo: attributes.weibo,
      naver: attributes.naver,
      website: attributes.website,
      createdAt: attributes.createdAt,
      updatedAt: attributes.updatedAt,
      version: attributes.version,
    );
  }
}

@singleton
class MangaTagMapper {
  MangaTag toTag(MangaTagDataDTO dto) {
    final attributes = dto.attributes!;

    return MangaTag(
      id: dto.id,
      group: attributes.group,
      name: {
        for (final entry in attributes.name.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
      description: {
        for (final entry in attributes.description.entries) Locale.fromSubtags(languageCode: entry.key): entry.value,
      },
    );
  }
}

@singleton
class CoverArtMapper {
  final AppEnv appEnv;

  CoverArtMapper(this.appEnv);

  String toCoverArtUrl(CoverArtDataDTO dto, String mangaId) {
    final attributes = dto.attributes!;

    return path.join(appEnv.uploadsApiUrl, 'covers', mangaId, attributes.fileName);
  }
}
