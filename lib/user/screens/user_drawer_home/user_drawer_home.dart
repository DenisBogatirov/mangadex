// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_urls.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';
import 'package:mangadex/infrastructure/router/user_drawer_router.gr.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/theme/mangadex_theme.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/screens/widgets/drawer_icon_button.dart';
import 'package:mangadex/user/screens/widgets/role_chip.dart';
import 'package:mangadex/widgets/svg_icon.dart';
import 'user_drawer_cubit.dart';

@RoutePage()
class UserDrawerHomePage extends StatelessWidget {
  const UserDrawerHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return BlocBuilder<UserDrawerCubit, UserDrawerState>(
      builder: (context, state) {
        if (state is UserDrawerInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final user = (state as UserDrawerReady).user;
        final isGuest = user is GuestUser;
        final List<Widget> roles = [];

        for (var role in user.roles) {
          roles.add(RoleChip(role: role));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UserAvatar(url: user.avatar, radius: 32),
                  const Divider(),
                  Center(
                    child: Text(
                      user.username,
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: roles,
                  ),
                  Divider(
                    color: MangaDexColors.dividerColor,
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DrawerIconButton(
                        onPressed: () {},
                        text: LocaleKeys.settings.tr(),
                        iconAsset: Assets.assetsSettingsIcon,
                      ),
                      const VerticalDivider(),
                      DrawerIconButton(
                        onPressed: () {
                          context.router.push(const UserDrawerThemeRoute());
                        },
                        text: LocaleKeys.theme.tr(),
                        iconAsset: Assets.assetsDropIcon,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.interface.tr()),
                        const _BetaLabel(),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(LocaleKeys.chapterLanguages.tr()),
                        // TODO: Add flag
                        const SizedBox(
                          width: 24,
                          height: 18,
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: context.theme.textButtonTheme.style?.copyWith(
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(LocaleKeys.contentFilter.tr()),
                  ),
                  Divider(
                    color: MangaDexColors.dividerColor,
                    height: 32,
                  ),
                  if (isGuest) ...{
                    ElevatedButton(
                      onPressed: () {
                        scaffold.closeEndDrawer();
                        AppRouter.instance.push(const SignInRoute());
                      },
                      child: Text(LocaleKeys.signInButton.tr()),
                    ),
                    TextButton(
                      onPressed: () async {
                        if (await url_launcher.canLaunchUrl(MangaDexUrls.register)) {
                          url_launcher.launchUrl(
                            MangaDexUrls.register,
                            mode: url_launcher.LaunchMode.externalApplication,
                          );
                        }
                      },
                      child: Text(LocaleKeys.register.tr()),
                    ),
                  } else ...{
                    DrawerIconButton(
                      onPressed: () => context.read<UserDrawerCubit>().signOut(),
                      text: LocaleKeys.signOut.tr(),
                      iconAsset: Assets.assetsSignOutIcon,
                    ),
                  }
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class UserAvatar extends StatelessWidget {
  final double? radius;
  final String? url;

  const UserAvatar({
    super.key,
    this.radius,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final width = radius != null ? radius! * 2 : null;
    final netWorkImage = url != null ? NetworkImage(url!) : null;
    final guestImage = url == null ? SvgIcon(asset: Assets.assetsGuestIcon, width: width) : null;

    return CircleAvatar(
      foregroundImage: netWorkImage,
      backgroundColor: Colors.transparent,
      radius: radius,
      child: guestImage,
    );
  }
}

class _BetaLabel extends StatelessWidget {
  const _BetaLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        LocaleKeys.betaLabel.tr(),
        style: context.theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
