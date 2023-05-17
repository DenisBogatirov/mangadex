// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:mangadex/infrastructure/mangadex_theme.dart';

class AuthCardHeader extends StatelessWidget {
  final String text;

  const AuthCardHeader(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: context.theme.textTheme.titleLarge,
      ),
    );
  }
}
