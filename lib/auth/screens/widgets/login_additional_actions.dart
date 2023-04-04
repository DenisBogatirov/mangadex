// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_urls.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/text_link.dart';

class LoginAdditionalActions extends StatelessWidget {
  final String rememberMeControlName;

  const LoginAdditionalActions({
    super.key, required this.rememberMeControlName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: Checkbox.width,
              height: Checkbox.width,
              child: ReactiveCheckbox(
                formControlName: rememberMeControlName,
              ),
            ),
            const VerticalDivider(),
            Text(LocaleKeys.rememberMe.tr())
          ],
        ),
        TextLink.url(
          LocaleKeys.forgotPassword.tr(),
          destinationUrl: MangaDexUrls.forgotPassword,
        ),
      ],
    );
  }
}
