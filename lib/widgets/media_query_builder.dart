// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

class MediaQueryBuilder extends StatelessWidget {
  final WidgetBuilder fallback;
  final Map<int, WidgetBuilder>? stops;

  const MediaQueryBuilder({
    super.key,
    required this.fallback,
    this.stops,
  });

  @override
  Widget build(BuildContext context) {
    final stops = this.stops;

    if (stops != null && stops.isNotEmpty) {
      final width = MediaQuery.of(context).size.width;
      final sorted = stops.keys.sorted((a, b) => a - b);


      if (width < sorted.first) {
        return fallback(context);
      }

      for (final stop in sorted) {
        if (width < stop) {
          return stops[stop]!(context);
        }
      }

      return stops[sorted.last]!(context);
    }

    return fallback(context);
  }
}
