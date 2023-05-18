// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/mangadex_urls.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';
import 'package:mangadex/infrastructure/router/user_drawer_router.gr.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/user/domain/user.dart';
import 'package:mangadex/user/screens/widgets/drawer_icon_button.dart';
import 'package:mangadex/user/screens/widgets/role_chip.dart';
import 'package:mangadex/user/screens/widgets/user_avatar.dart';
import 'package:mangadex/user/utils/current_user_cubit.dart';

class _DrawerMenuOption {
  final String Function() title;
  final String iconAsset;
  final PageRouteInfo Function() _destination;

  const _DrawerMenuOption({
    required this.title,
    required this.iconAsset,
    required PageRouteInfo Function() destination,
  }) : _destination = destination;

  void navigate(BuildContext context) {
    final router = AppRouter.instance.innerRouterOf<StackRouter>(HomeRoute.name)!;
    Scaffold.of(context).closeEndDrawer();

    router.replaceAll([_destination()]);
  }
}

final _menuOptions = [
  _DrawerMenuOption(
    title: () => LocaleKeys.myProfile.tr(),
    iconAsset: Assets.assetsGuestIcon,
    destination: () => const NotImplementedRoute(),
  ),
  _DrawerMenuOption(
    title: () => LocaleKeys.myFollows.tr(),
    iconAsset: Assets.assetsFollowsIcon,
    destination: () => const NotImplementedRoute(),
  ),
  _DrawerMenuOption(
    title: () => LocaleKeys.myLists.tr(),
    iconAsset: Assets.assetsListIcon,
    destination: () => const NotImplementedRoute(),
  ),
  _DrawerMenuOption(
    title: () => LocaleKeys.myGroups.tr(),
    iconAsset: Assets.assetsGroupIcon,
    destination: () => const NotImplementedRoute(),
  ),
  _DrawerMenuOption(
    title: () => LocaleKeys.myReports.tr(),
    iconAsset: Assets.assetsReportIcon,
    destination: () => const NotImplementedRoute(),
  ),
  _DrawerMenuOption(
    title: () => LocaleKeys.announcements.tr(),
    iconAsset: Assets.assetsAnnouncementIcon,
    destination: () => const NotImplementedRoute(),
  ),
];

@RoutePage()
class UserDrawerHomePage extends StatelessWidget {
  const UserDrawerHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        return switch (state) {
          CurrentUserLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          CurrentUserReady(user: User user, isGuest: bool isGuest) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DrawerUserInfo(user: user),
                      if (!isGuest) ...{
                        Divider(
                          color: MangaDexColors.dividerColor,
                          height: 32,
                        ),
                        for (final menuOption in _menuOptions)
                          DrawerIconButton(
                            onPressed: () => menuOption.navigate(context),
                            iconAsset: menuOption.iconAsset,
                            text: menuOption.title(),
                          ),
                      },
                      Divider(
                        color: MangaDexColors.dividerColor,
                        height: 32,
                      ),
                      const DrawerSettings(),
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
                          onPressed: () => context.read<CurrentUserCubit>().signOut(),
                          text: LocaleKeys.signOut.tr(),
                          iconAsset: Assets.assetsSignOutIcon,
                        ),
                      }
                    ],
                  ),
                )
              ],
            )
        };
      },
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
          color: context.theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class DrawerUserInfo extends StatelessWidget {
  final User user;

  const DrawerUserInfo({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: UserAvatar(url: user.avatar, radius: 32)),
        const Divider(),
        Center(
          child: Text(
            user.username,
            style: context.theme.textTheme.titleLarge,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (final role in user.roles) RoleChip(role: role),
          ],
        )
      ],
    );
  }
}

class DrawerSettings extends StatelessWidget {
  const DrawerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
      ],
    );
  }
}
