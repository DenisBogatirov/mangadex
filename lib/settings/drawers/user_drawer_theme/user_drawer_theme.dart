// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_assets.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/settings/domain/user_theme.dart';
import 'package:mangadex/settings/drawers/user_drawer_theme/theme_cubit.dart';
import 'package:mangadex/widgets/svg_icon.dart';

@RoutePage()
class UserDrawerThemePage extends StatelessWidget {
  const UserDrawerThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, UserTheme>(
      builder: (context, currentTheme) {
        return StaticListView(
          itemCount: UserTheme.values.length,
          itemBuilder: (context, index) {
            final theme = UserTheme.values[index];
            final isSelected = currentTheme == theme;

            return TextButton(
              onPressed: () {
                if (!isSelected) {
                  context.read<ThemeCubit>().changeTheme(theme);
                }
              },
              child: Row(
                children: [
                  Text([LocaleKeys.themeMode, theme.name].join('.').tr()),
                  if (isSelected) ...{
                    const VerticalDivider(),
                    SvgIcon(
                      asset: Assets.assetsCheckIcon,
                      color: context.theme.colorScheme.primary,
                    ),
                  }
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class StaticListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;

  const StaticListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < itemCount; i++) {
      final widget = itemBuilder(context, i);
      final separator = separatorBuilder != null ? separatorBuilder!(context, i) : null;

      children.add(widget);
      if (separator != null) {
        children.add(separator);
      }
    }

    return Column(
      children: children,
    );
  }
}
