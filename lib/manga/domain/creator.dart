// Dart imports:
import 'dart:ui';

// Package imports:
import 'package:equatable/equatable.dart';

abstract class Creator extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final Map<Locale, String> biography;
  final String? twitter;
  final String? pixiv;
  final String? melonBook;
  final String? fanBox;
  final String? booth;
  final String? nicoVideo;
  final String? skeb;
  final String? fantia;
  final String? tumblr;
  final String? youtube;
  final String? weibo;
  final String? naver;
  final String? website;
  final String createdAt;
  final String updatedAt;
  final int version;

  const Creator({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.biography,
    this.twitter,
    this.pixiv,
    this.melonBook,
    this.fanBox,
    this.booth,
    this.nicoVideo,
    this.skeb,
    this.fantia,
    this.tumblr,
    this.youtube,
    this.weibo,
    this.naver,
    this.website,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  @override
  List<Object?> get props => [id];
}

class Author extends Creator {
  const Author({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.biography,
    super.twitter,
    super.pixiv,
    super.melonBook,
    super.fanBox,
    super.booth,
    super.nicoVideo,
    super.skeb,
    super.fantia,
    super.tumblr,
    super.youtube,
    super.weibo,
    super.naver,
    super.website,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });
}

class Artist extends Creator {
  const Artist({
    required super.id,
    required super.name,
    super.imageUrl,
    required super.biography,
    super.twitter,
    super.pixiv,
    super.melonBook,
    super.fanBox,
    super.booth,
    super.nicoVideo,
    super.skeb,
    super.fantia,
    super.tumblr,
    super.youtube,
    super.weibo,
    super.naver,
    super.website,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });
}
