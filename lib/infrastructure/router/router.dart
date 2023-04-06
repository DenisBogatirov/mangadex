// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/sign-in', page: SignInRoute.page),
    AutoRoute(path: '/', page: HomeRoute.page),
  ];
}
