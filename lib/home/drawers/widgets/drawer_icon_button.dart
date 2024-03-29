// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/widgets/svg_icon.dart';

class DrawerIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconAsset;
  final String text;

  const DrawerIconButton({
    super.key,
    required this.onPressed,
    required this.iconAsset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: context.theme.textButtonTheme.style!.copyWith(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgIcon(asset: iconAsset),
          const VerticalDivider(),
          Text(text),
        ],
      ),
    );
  }
}
