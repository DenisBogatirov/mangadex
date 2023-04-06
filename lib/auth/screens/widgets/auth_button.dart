// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:reactive_forms/reactive_forms.dart';

// Project imports:
import 'package:mangadex/theme/mangadex_theme.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context)!;
    final isEnabled = !isLoading && form.valid;
    final fontSize = context.theme.textTheme.labelLarge!.fontSize!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            if (isLoading) ...{
              const VerticalDivider(),
              SizedBox.square(
                dimension: fontSize,
                child: CircularProgressIndicator(
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
