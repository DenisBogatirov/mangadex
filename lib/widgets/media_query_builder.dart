// Flutter imports:
import 'package:flutter/material.dart';

class MediaQueryBuilder extends StatelessWidget {
  final WidgetBuilder fallback;

  const MediaQueryBuilder({
    super.key,
    required this.fallback,
  });

  // TODO: Implement media query points
  @override
  Widget build(BuildContext context) {
    return fallback(context);
  }
}
