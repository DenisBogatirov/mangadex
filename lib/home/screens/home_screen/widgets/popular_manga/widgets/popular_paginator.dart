// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:mangadex/infrastructure/assets.gen.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/media_query_builder.dart';
import 'package:mangadex/widgets/svg_icon.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';

part 'mobile_popular_paginator.dart';
part 'tablet_popular_paginator.dart';
part 'desktop_popular_paginator.dart';

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
    return Container(
      height: kPopularPaginatorHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MediaQueryBuilder(
        desktop: (context) => _PopularPaginatorDesktop(
          onPrev: onPrev,
          onNext: onNext,
          page: page,
        ),
        tablet: (context) => _PopularPaginatorTablet(onPrev: onPrev, onNext: onNext),
        mobile: (context) => _PopularPaginatorMobile(
          onPrev: onPrev,
          onNext: onNext,
          text: '$page/$total',
        ),
      ),
    );
  }

  void onPrev() {
    if (pageController.page == 0) {
      pageController.jumpToPage(total);
    }
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
