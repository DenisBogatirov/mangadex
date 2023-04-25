// Flutter imports:
import 'package:flutter/material.dart';

class FocusRemover extends StatelessWidget {
  final Widget child;

  const FocusRemover({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
