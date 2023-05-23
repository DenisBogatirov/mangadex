// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/home/drawers/widgets/user_avatar.dart';
import 'package:mangadex/infrastructure/mangadex_assets.dart';
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
          icon: BlocBuilder<CurrentUserCubit, CurrentUserState>(
            builder: (context, state) {
              return switch (state) {
                CurrentUserLoading() => const SizedBox.square(
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
  }
}
