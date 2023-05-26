// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

enum MediaQueryStop {
  mobile(0),
  tablet(640),
  desktop(768);

  final int stop;

  const MediaQueryStop(this.stop);

  static List<MediaQueryStop> get sorted => values.sorted((a, b) => b.stop - a.stop);
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
      MediaQueryStop.mobile: mobile,
      MediaQueryStop.tablet: tablet ?? mobile,
      MediaQueryStop.desktop: desktop ?? tablet ?? mobile,
    };

    final width = MediaQuery.of(context).size.width;

    for (final stop in MediaQueryStop.sorted) {
      if (width >= stop.stop) {
        return builders[stop]!(context);
      }
    }

    return mobile(context);
  }
}
