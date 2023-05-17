// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/user/domain/user.dart';

const _rolesTranslations = {
  UserRole.user: LocaleKeys.userRolesUser,
};

class RoleChip extends StatelessWidget {
  final UserRole role;

  const RoleChip({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        _rolesTranslations[role]!.tr(),
        style: context.theme.textTheme.bodyMedium?.copyWith(color: MangaDexColors.lightOnBackground),
      ),
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
