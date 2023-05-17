// Package imports:
import 'package:auto_route/auto_route.dart';

class NoTransitionRoute extends CustomRoute {
  NoTransitionRoute({
    required super.page,
    super.fullscreenDialog,
    super.maintainState,
    super.fullMatch,
    super.guards,
    super.usesPathAsKey,
    super.children,
    super.meta,
    super.title,
    super.path,
    super.keepHistory,
    super.initial,
    super.customRouteBuilder,
    super.opaque,
    super.barrierDismissible,
    super.barrierLabel,
    super.restorationId,
    super.barrierColor,
  }) : super(
    transitionsBuilder: TransitionsBuilders.noTransition,
    durationInMilliseconds: 0,
    reverseDurationInMilliseconds: 0,
  );
}
