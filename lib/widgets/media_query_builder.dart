// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

enum _MediaQueryStop {
  mobile(0),
  tablet(640),
  desktop(768);

  final int stop;

  const _MediaQueryStop(this.stop);

  static List<_MediaQueryStop> get sorted => values.sorted((a, b) => b.stop - a.stop);
}

class MediaQueryBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  const MediaQueryBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final builders = {
      _MediaQueryStop.mobile: mobile,
      _MediaQueryStop.tablet: tablet ?? mobile,
      _MediaQueryStop.desktop: desktop ?? tablet ?? mobile,
    };

    final width = MediaQuery.of(context).size.width;

    for (final stop in _MediaQueryStop.sorted) {
      if (width >= stop.stop) {
        return builders[stop]!(context);
      }
    }

    return mobile(context);
  }
}
