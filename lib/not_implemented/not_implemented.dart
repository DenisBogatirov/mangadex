// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

// Project imports:
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';

@RoutePage()
class NotImplementedScreen extends StatelessWidget {
  const NotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(LocaleKeys.notImplemented.tr()),
    );
  }
}
