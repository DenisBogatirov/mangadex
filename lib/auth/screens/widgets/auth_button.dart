// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:reactive_forms/reactive_forms.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final form = ReactiveForm.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: form.valid ? onPressed : null,
        child: child,
      ),
    );
  }
}
