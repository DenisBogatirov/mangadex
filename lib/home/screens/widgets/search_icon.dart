// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/widgets/svg_icon.dart';

// Package imports:


class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.accentColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: const SvgIcon(
            asset: Assets.assetsSearchIcon,
          ),
        ),
      ),
    );
  }
}
