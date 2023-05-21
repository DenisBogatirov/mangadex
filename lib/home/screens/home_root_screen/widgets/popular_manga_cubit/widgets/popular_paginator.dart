// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/widgets/media_query_builder.dart';
import 'package:mangadex/widgets/svg_icon.dart';

const kPopularPaginatorHeight = 64.0;
const kPaginatorDuration = Duration(milliseconds: 400);
const kPaginatorCurve = Curves.easeInOut;

class PopularPaginator extends StatelessWidget {
  final PageController pageController;
  final int page;
  final int total;

  const PopularPaginator({
    super.key,
    required this.pageController,
    required this.page,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.background;

    return Container(
      height: kPopularPaginatorHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MediaQueryBuilder(
        fallback: (context) => _PopularPaginatorMobile(
          onPrev: onPrev,
          onNext: onNext,
          text: '$page/$total',
        ),
      ),
    );
  }

  void onPrev() {
    pageController.previousPage(
      duration: kPaginatorDuration,
      curve: kPaginatorCurve,
    );
  }

  void onNext() {
    pageController.nextPage(
      duration: kPaginatorDuration,
      curve: kPaginatorCurve,
    );
  }
}

class _PopularPaginatorMobile extends StatelessWidget {
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final String text;

  const _PopularPaginatorMobile({
    required this.onPrev,
    required this.onNext,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.background;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onPrev,
          child: _PaginatorItemWrapperMobile(
            child: SvgIcon(
              asset: Assets.assetsChevronLeft,
              color: color,
            ),
          ),
        ),
        _PaginatorItemWrapperMobile(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              text,
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onNext,
          child: _PaginatorItemWrapperMobile(
            child: SvgIcon(
              asset: Assets.assetsChevronRight,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaginatorItemWrapperMobile extends StatelessWidget {
  final Widget child;

  const _PaginatorItemWrapperMobile({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.isDark;
    final backgroundColor = isDark ? Colors.white : HexColor('#242424');

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(kPopularPaginatorHeight),
      ),
      child: child,
    );
  }
}
