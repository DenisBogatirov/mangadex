// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/infrastructure/assets.gen.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';

class AppBarLogo extends StatelessWidget {
  const AppBarLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorScheme.onBackground;
    final dividerWidth = context.theme.dividerTheme.space! / 2;

    return GestureDetector(
      onTap: () {
        if (context.router.topRoute.name != HomeRoute.name) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      child: Row(
        children: [
          SvgPicture.asset(Assets.mangadexLogo),
          VerticalDivider(width: dividerWidth),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                Assets.mangadexWordmark,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
