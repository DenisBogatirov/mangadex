// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/theme/mangadex_theme.dart';
import 'package:mangadex/user/screens/widgets/role_chip.dart';
import 'package:mangadex/widgets/svg_icon.dart';
import 'package:mangadex/widgets/svg_icon_button.dart';
import 'user_drawer_cubit.dart';

const kDrawerConstraints = BoxConstraints(maxWidth: 320, minWidth: 256, maxHeight: double.infinity);

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
      child: BlocBuilder<UserDrawerCubit, UserDrawerState>(
        builder: (context, state) {
          if (state is UserDrawerInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = (state as UserDrawerReady).user;
          final List<Widget> roles = [];

          for (var role in user.roles) {
            roles.add(RoleChip(role: role));
          }

          return SingleChildScrollView(
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
                          UserAvatar(url: user.avatar, radius: 32),
                          const Divider(),
                          Text(
                            user.username,
                            style: context.theme.textTheme.titleLarge,
                          ),
                          Wrap(
                            children: roles,
                          ),
                          Divider(
                            color: MangaDexColors.dividerColor,
                            height: 32,
                          ),
                          TextButton(
                            onPressed: () => context.read<UserDrawerCubit>().signOut(),
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
          );
        },
      ),
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
