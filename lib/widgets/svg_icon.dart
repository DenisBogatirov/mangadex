// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/theme/mangadex_theme.dart';

class SvgIcon extends StatelessWidget {
  final String asset;

  const SvgIcon({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(
        context.theme.colorScheme.onBackground,
        BlendMode.srcIn,
      ),
    );
  }
}
