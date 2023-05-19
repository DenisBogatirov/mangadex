// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/manga/domain/manga.dart';
import 'package:mangadex/widgets/svg_icon.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';
import 'popular_manga_cubit.dart';

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
      maxHeight: 352,
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
                          onPageChanged: (page) {
                            setState(() {
                              _page = (page % 10) + 1;
                            });
                          },
                          controller: _pageController,
                          itemBuilder: (context, index) {
                            final manga = mangaList[index % 10];

                            return PopularMangaTile(manga: manga);
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // TODO: Style buttons
                              SvgIconButton(
                                onPressed: () {
                                  // Loop back
                                  if (_pageController.page! % 10 == 0) {
                                    _pageController.jumpToPage(10);
                                  }
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                asset: Assets.assetsChevronLeft,
                              ),
                              Chip(
                                label: Text(
                                  '$_page/${mangaList.length}',
                                  style: context.theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SvgIconButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                asset: Assets.assetsChevronRight,
                              ),

                              // FilledButton.tonal(
                              //
                              //   onPressed: () {},
                              //   style: context.theme.filledButtonTheme.style?.copyWith(
                              //     padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                              //   ),
                              //   child: const SvgIcon(asset: Assets.assetsChevronRight),
                              // ),
                            ],
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
}

class PopularMangaTile extends StatefulWidget {
  final Manga manga;

  const PopularMangaTile({
    super.key,
    required this.manga,
  });

  @override
  State<PopularMangaTile> createState() => _PopularMangaTileState();
}

class _PopularMangaTileState extends State<PopularMangaTile> with AutomaticKeepAliveClientMixin<PopularMangaTile> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(imageUrl: widget.manga.coverArt, fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.theme.colorScheme.background,
                  Colors.transparent,
                  Colors.transparent,
                  context.theme.colorScheme.background,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
