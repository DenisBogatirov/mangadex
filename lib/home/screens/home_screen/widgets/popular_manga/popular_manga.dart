// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/manga/manga_backdrop.dart';
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
                      pageSnapping: false,
                      onPageChanged: _onPageChanged,
                      controller: _backDropController,
                      itemBuilder: (context, index) {
                        final manga = mangaList[index % 10];

                        return MangaBackdrop(manga: manga);
                      },
                    ),
                };
              }),
            ),
            const _BackdropGradient()
          },
          Positioned.fill(
            top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    LocaleKeys.popularNewTitles.tr(),
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
                const Divider(),
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

class _BackdropGradient extends StatelessWidget {
  const _BackdropGradient();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(
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
    );
  }
}
