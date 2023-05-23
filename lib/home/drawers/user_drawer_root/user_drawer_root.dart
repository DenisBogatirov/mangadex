// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/router/user_drawer_router.gr.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';

@RoutePage()
class UserDrawerRootPage extends StatelessWidget {
  const UserDrawerRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverSafeArea(
          bottom: false,
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: DrawerLeadingButton(),
              ),
            ),
          ),
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverFillRemaining(
              hasScrollBody: false,
              child: AutoRouter(),
            ),
          ),
        ),
      ],
    );
  }
}

class DrawerLeadingButton extends StatelessWidget {
  const DrawerLeadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.watchRouter;

    if (router.canPop()) {
      return Row(
        children: [
          SvgIconButton(
            asset: Assets.assetsBackIcon,
            onPressed: () => context.innerRouterOf(UserDrawerRootRoute.name)?.pop(),
          ),
          Text(
            router.topRoute.title(context),
            style: context.theme.textTheme.labelLarge,
          ),
        ],
      );
    }

    return SvgIconButton(
      asset: Assets.assetsCloseIcon,
      onPressed: () => Scaffold.of(context).closeEndDrawer(),
    );
  }
}
