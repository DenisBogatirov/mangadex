// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:mangadex/home/drawers/widgets/user_avatar.dart';
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/utils/current_user_cubit.dart';
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

    return Consumer<ScrollController>(builder: (context, controller, child) {
      double opacity = 0;

      if (controller.positions.isNotEmpty) {
        opacity = controller.position.pixels.clamp(0.0, kToolbarHeight) / kToolbarHeight;
      }

      return SliverAppBar(
        pinned: true,
        shadowColor: context.theme.appBarTheme.shadowColor?.withOpacity(opacity),
        backgroundColor: context.theme.appBarTheme.backgroundColor?.withOpacity(opacity),
        leading: SvgIconButton(
          asset: Assets.assetsMenuIcon,
          onPressed: () => scaffold.openDrawer(),
        ),
        title: const AppBarLogo(),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Divider(
            color: context.theme.colorScheme.primary.withOpacity(opacity),
            height: 0,
          ),
        ),
        actions: [
          const SearchIcon(),
          IconButton(
            icon: BlocBuilder<CurrentUserCubit, CurrentUserState>(
              builder: (context, state) {
                return switch (state) {
                  CurrentUserLoading() =>
                  const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  CurrentUserReady(user: User user) => UserAvatar(url: user.avatar),
                };
              },
            ),
            onPressed: () => scaffold.openEndDrawer(),
          ),
        ],
      );
     });
  }
}
