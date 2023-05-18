// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  static AppRouter get instance => GetIt.instance.get();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/sign-in', page: SignInRoute.page),
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      children: [
        AutoRoute(
          path: 'not-implemented',
          page: NotImplementedRoute.page,
          initial: true,
        )
      ],
    ),
  ];
}
