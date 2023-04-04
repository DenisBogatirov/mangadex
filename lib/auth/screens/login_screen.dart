// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_urls.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/theme/mangadex_theme.dart';
import 'package:mangadex/widgets/fields/password_field.dart';
import 'package:mangadex/widgets/fields/username_email_field.dart';
import 'package:mangadex/widgets/text_link.dart';
import 'widgets/auth_button.dart';
import 'widgets/auth_card.dart';
import 'widgets/auth_card_header.dart';
import 'widgets/auth_container.dart';
import 'widgets/auth_prompt_container.dart';
import 'widgets/login_additional_actions.dart';

enum LoginField {
  login('login'),
  password('password'),
  rememberMe('rememberMe');

  final String value;

  const LoginField(this.value);
}

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formGroup = FormGroup({
    LoginField.login.value: FormControl<String>(validators: [Validators.required]),
    LoginField.password.value: FormControl<String>(validators: [Validators.required]),
    LoginField.rememberMe.value: FormControl<bool>(),
  });

  @override
  Widget build(_) {
    return AuthContainer(
      child: AuthCard(
        child: Column(
          children: [
            AuthCardHeader(LocaleKeys.signInMessage.tr()),
            Divider(height: context.theme.dividerTheme.space! * 2),
            ReactiveForm(
              formGroup: formGroup,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UsernameEmailField(formControlName: LoginField.login.value),
                  const Divider(height: 15),
                  PasswordField(formControlName: LoginField.password.value),
                  const Divider(),
                  LoginAdditionalActions(rememberMeControlName: LoginField.rememberMe.value),
                  Divider(height: context.theme.dividerTheme.space! * 2),
                  AuthButton(
                    onPressed: _onSubmit,
                    child: Text(LocaleKeys.signInButton.tr()),
                  ),
                  Divider(height: context.theme.dividerTheme.space! * 1.5),
                  AuthPromptContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(LocaleKeys.newUserQuestion.tr()),
                        const VerticalDivider(),
                        TextLink.url(LocaleKeys.register.tr(), destinationUrl: MangaDexUrls.register),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();
  }
}
