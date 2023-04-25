// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';
import 'app_logo.dart';
import 'search_icon.dart';

class MangaDexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MangaDexAppBar({
    super.key,
  });

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return AppBar(
      leading: SvgIconButton(
        asset: Assets.assetsMenuIcon,
        onPressed: () => scaffold.openDrawer(),
      ),
      title: const AppBarLogo(),
      centerTitle: false,
      actions: [
        const SearchIcon(),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => scaffold.openEndDrawer(),
        ),
      ],
    );
  }
}
