// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/widgets/svg_icon.dart';

class SvgIconButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const SvgIconButton({
    super.key,
    required this.asset,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgIcon(asset: asset),
      onPressed: onPressed,
    );
  }
}
