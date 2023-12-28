// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/auth.exceptions.dart';
import 'package:mangadex/auth/screens/sign_in/sign_in_cubit.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/mangadex_urls.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/widgets/fields/password_field.dart';
import 'package:mangadex/widgets/fields/username_email_field.dart';
import 'package:mangadex/widgets/text_link.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_card_header.dart';
import '../widgets/auth_container.dart';
import '../widgets/auth_prompt_container.dart';
import '../widgets/sign_in_additional_actions.dart';

enum SignInField {
  username('username'),
  password('password'),
  rememberMe('rememberMe');

  final String value;

  const SignInField(this.value);
}

@RoutePage()
class SignInScreen extends StatefulWidget implements AutoRouteWrapper {
  const SignInScreen({
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (context) => context.read<GetIt>().get(),
      child: this,
    );
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final formGroup = FormGroup({
    SignInField.username.value: FormControl<String>(validators: [Validators.required]),
    SignInField.password.value: FormControl<String>(validators: [Validators.required, Validators.minLength(8)]),
    SignInField.rememberMe.value: FormControl<bool>(value: false),
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: AuthContainer(
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
                    UsernameEmailField(formControlName: SignInField.username.value),
                    const Divider(height: 15),
                    PasswordField(formControlName: SignInField.password.value),
                    const Divider(),
                    SignInAdditionalActions(rememberMeControlName: SignInField.rememberMe.value),
                    Divider(height: context.theme.dividerTheme.space! * 2),
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        return AuthButton(
                          onPressed: _onSubmit,
                          isLoading: state == SignInState.loading,
                          child: Text(LocaleKeys.signInButton.tr()),
                        );
                      },
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
      ),
    );
  }

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final theme = context.theme;

    final payload = UsernamePayload(
      username: formGroup.control(SignInField.username.value).value as String,
      password: formGroup.control(SignInField.password.value).value as String,
      rememberMe: formGroup.control(SignInField.rememberMe.value).value as bool,
    );

    try {
      await context.read<SignInCubit>().signIn(payload);
    } on WrongSignInCredentialsException catch (_) {
      formGroup.control(SignInField.username.value).setErrors({UsernameValidationMessages.invalid: true});
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            '!!UNKNOWN ERROR!!',
            style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.onError),
          ),
          backgroundColor: theme.colorScheme.error,
        ),
      );
    }
  }
}
