// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/infrastructure/assets.gen.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';

class AuthAppLogo extends StatelessWidget {
  const AuthAppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.theme.textTheme.headlineMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.favicon,
            width: 48,
          ),
          VerticalDivider(
            width: context.theme.dividerTheme.space! / 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(LocaleKeys.appName.tr(), style: textStyle),
          ),
        ],
      ),
    );
  }
}
