// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'popular_manga_cubit.dart';
import 'widgets/popular_manga_tile.dart';
import 'widgets/popular_paginator.dart';

class PopularManga extends StatefulWidget {
  const PopularManga({super.key});

  @override
  State<PopularManga> createState() => _PopularMangaState();
}

class _PopularMangaState extends State<PopularManga> {
  final PageController _pageController = PageController();
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 352 - kToolbarHeight,
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
                  PopularMangaReady(manga: List<Manga> mangaList) => Stack(
                      children: [
                        PageView.builder(
                          onPageChanged: _onPageChanged,
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            final manga = mangaList[index % 10];

                            return PopularMangaTile(manga: manga);
                          },
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
    );
  }

  void _onPageChanged(page) {
    setState(() {
      _page = (page % 10) + 1;
    });
  }
}
