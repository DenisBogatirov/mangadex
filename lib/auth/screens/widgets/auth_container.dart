// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:mangadex/auth/screens/widgets/auth_app_logo.dart';
import 'package:mangadex/theme/mangadex_theme.dart';
import 'package:mangadex/widgets/focus_remover.dart';

class AuthContainer extends StatelessWidget {
  final Widget child;

  const AuthContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = buildTheme(Brightness.dark);

    final originalTheme = GoogleFonts.leagueSpartanTextTheme(theme.textTheme);
    final textTheme = originalTheme.copyWith(
      headlineMedium: originalTheme.headlineMedium!.copyWith(
        color: theme.colorScheme.onBackground,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: originalTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      titleMedium: originalTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      labelLarge: originalTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Theme(
        data: theme.copyWith(
          textTheme: textTheme,
          inputDecorationTheme: theme.inputDecorationTheme.copyWith(
            labelStyle: textTheme.titleMedium,
            errorStyle: textTheme.titleMedium!.copyWith(color: context.theme.colorScheme.error)
          ),
        ),
        child: FocusRemover(
          child: Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      children: [
                        const AuthAppLogo(),
                        const Divider(),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
