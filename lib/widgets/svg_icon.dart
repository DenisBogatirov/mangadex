// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';

class SvgIcon extends StatelessWidget {
  final String asset;
  final double? width;
  final Color? color;

  const SvgIcon({
    super.key,
    required this.asset,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: width,
      colorFilter: ColorFilter.mode(
        color ?? context.theme.colorScheme.onBackground,
        BlendMode.srcIn,
      ),
    );
  }
}
