// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hexcolor/hexcolor.dart';

class AuthPromptContainer extends StatelessWidget {
  final Widget child;

  const AuthPromptContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor('#2e2f37'),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
