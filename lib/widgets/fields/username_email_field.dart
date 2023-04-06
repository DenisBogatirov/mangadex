// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/mangadex_text_field.dart';

class UsernameValidationMessages {
  static const invalid = 'invalid';
}

final _defaultValidationMessages = {
  ValidationMessage.required: (error) => LocaleKeys.validationRequired.tr(
        namedArgs: {"field": LocaleKeys.signInFieldLabel.tr()},
      ),
  UsernameValidationMessages.invalid: (error) => LocaleKeys.invalidSignInCredentials.tr(),
};

class UsernameEmailField extends StatelessWidget {
  final String formControlName;
  final Map<String, ValidationMessageFunction>? validationMessages;

  UsernameEmailField({
    Key? key,
    required this.formControlName,
    Map<String, ValidationMessageFunction>? validationMessages,
  })  : validationMessages = {}
          ..addAll(_defaultValidationMessages)
          ..addAll(validationMessages ?? {}),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MangadexReactiveFormField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      decoration: InputDecoration(
        labelText: LocaleKeys.signInFieldLabel.tr(),
      ),
    );
  }
}
