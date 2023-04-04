// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/mangadex_text_field.dart';

final _defaultValidationMessages = {
  ValidationMessage.required: (error) => LocaleKeys.validationRequired.tr(
        namedArgs: {"field": LocaleKeys.loginFieldLabel.tr()},
      ),
};

class UsernameEmailField extends StatelessWidget {
  final String formControlName;

  const UsernameEmailField({
    Key? key,
    required this.formControlName,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MangadexReactiveFormField(
      formControlName: formControlName,
      validationMessages: _defaultValidationMessages,
      decoration: InputDecoration(
        labelText: LocaleKeys.loginFieldLabel.tr(),
      ),
    );
  }
}
