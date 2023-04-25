// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/theme/mangadex_theme.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.onBackground;
    final dividerWidth = context.theme.dividerTheme.space! / 2;

    return Row(
      children: [
        SvgPicture.asset(Assets.assetsMangadexLogo),
        VerticalDivider(width: dividerWidth),
        SvgPicture.asset(Assets.assetsMangadexWordmark, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
      ],
    );
  }
}
