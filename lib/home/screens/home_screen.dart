// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/theme/mangadex_theme.dart';
import 'package:mangadex/widgets/svg_icon.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';
import 'widgets/mangadex_app_bar.dart';

const kDrawerConstraints = BoxConstraints(maxWidth: 320, minWidth: 256, maxHeight: double.infinity);

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const MangaDexAppBar(),
      drawerEdgeDragWidth: 0,
      drawer: ConstrainedBox(
        constraints: kDrawerConstraints,
        child: Container(
          color: context.theme.colorScheme.background,
          child: const SafeArea(
            child: Placeholder(),
          ),
        ),
      ),
      endDrawer: const UserDrawer(),
      body: const SafeArea(child: Placeholder()),
    );
  }
}

class UserDrawer extends StatelessWidget {
  const UserDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return Container(
      constraints: kDrawerConstraints,
      height: kDrawerConstraints.maxHeight,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgIconButton(
                  asset: Assets.assetsCloseIcon,
                  onPressed: scaffold.closeEndDrawer,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const UserAvatar(),
                      const Divider(),
                      Text(
                        '!!godlydb!!',
                        style: context.theme.textTheme.titleLarge,
                      ),
                      Wrap(
                        children: const [
                          RoleChip(role: UserRole.user),
                        ],
                      ),
                      Divider(
                        color: MangaDexColors.dividerColor,
                        height: 32,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            const SvgIcon(asset: Assets.assetsSignOutIcon),
                            const VerticalDivider(),
                            Text(LocaleKeys.signOut.tr()),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum UserRole {
  user('ROLE_USER');

  final String value;

  const UserRole(this.value);
}

class RoleChip extends StatelessWidget {
  final UserRole role;

  const RoleChip({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(role.value, style: context.theme.textTheme.bodyMedium?.copyWith(color: MangaDexColors.lightOnBackground),),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String url;

  const UserAvatar({
    super.key,
    this.url = 'https://mangadex.org/img/avatar.png',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(url),
      radius: 32,
    );
  }
}
