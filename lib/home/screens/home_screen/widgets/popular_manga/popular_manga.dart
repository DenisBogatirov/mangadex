// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/widgets/media_query_builder.dart';
import 'popular_manga_cubit.dart';
import 'widgets/popular_manga_tile.dart';
import 'widgets/popular_paginator.dart';

class PopularManga extends StatefulWidget {
  const PopularManga({super.key});

  @override
  State<PopularManga> createState() => _PopularMangaState();
}

class _PopularMangaState extends State<PopularManga> {
  final PageController _pageController = PageController(initialPage: 10);
  final PageController _backDropController = PageController();

  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 352 + MediaQuery.of(context).viewPadding.top,
      child: Stack(
        children: [
          if (MediaQuery.of(context).size.width < MediaQueryStop.tablet.stop) ...{
            Positioned.fill(
              child: BlocBuilder<PopularMangaCubit, PopularMangaState>(builder: (context, state) {
                return switch (state) {
                  PopularMangaLoading() => const SizedBox.shrink(),
                  PopularMangaReady(manga: final mangaList) => PageView.builder(
                      onPageChanged: _onPageChanged,
                      controller: _backDropController,
                      itemBuilder: (context, index) {
                        final manga = mangaList[index % 10];

                        return MangaBackDrop(manga: manga);
                      },
                    ),
                };
              }),
            ),
          },
          Positioned.fill(
            top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.popular.tr(),
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<PopularMangaCubit, PopularMangaState>(
                    builder: (context, state) {
                      return switch (state) {
                        PopularMangaLoading() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        PopularMangaReady(manga: final mangaList) => Stack(
                            children: [
                              NotificationListener<ScrollNotification>(
                                onNotification: (ScrollNotification notification) {
                                  if (_backDropController.positions.isNotEmpty) {
                                    _backDropController.jumpTo(notification.metrics.pixels);
                                  }
                                  return false;
                                },
                                child: PageView.builder(
                                  onPageChanged: _onPageChanged,
                                  controller: _pageController,
                                  itemBuilder: (context, index) {
                                    final manga = mangaList[index % 10];

                                    return PopularMangaTile(manga: manga);
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: PopularPaginator(
                                  pageController: _pageController,
                                  page: _page,
                                  total: mangaList.length,
                                ),
                              ),
                            ],
                          ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPageChanged(page) {
    setState(() {
      _page = (page % 10) + 1;
    });
  }
}

class MangaBackDrop extends StatefulWidget {
  final Manga manga;

  const MangaBackDrop({
    super.key,
    required this.manga,
  });

  @override
  State<MangaBackDrop> createState() => _MangaBackDropState();
}

class _MangaBackDropState extends State<MangaBackDrop> with AutomaticKeepAliveClientMixin<MangaBackDrop> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Positioned.fill(child: CachedNetworkImage(imageUrl: widget.manga.coverArt, fit: BoxFit.cover)),
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
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
