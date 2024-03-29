// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';

const kDrawerConstraints = BoxConstraints(maxWidth: 320, minWidth: 256, maxHeight: double.infinity);

class DrawerContainer extends StatelessWidget {
  final Widget? child;

  const DrawerContainer({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: kDrawerConstraints,
      height: kDrawerConstraints.maxHeight,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
      ),
      child: child,
    );
  }
}
