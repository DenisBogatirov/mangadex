// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'no_transition_route.dart';
import 'user_drawer_router.gr.dart';

@Singleton()
@AutoRouterConfig(replaceInRouteName: 'Page,Route', generateForDir: ['lib/user/screens/user_drawer'])
class UserDrawerRouter extends $UserDrawerRouter {
  static UserDrawerRouter get instance => GetIt.instance.get();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: UserDrawerRootRoute.page,
      initial: true,
      children: [
        NoTransitionRoute(
          initial: true,
          page: UserDrawerHomeRoute.page,
        ),
        NoTransitionRoute(
          page: UserDrawerThemeRoute.page,
          title: (context, data) => LocaleKeys.selectTheme.tr(),
        ),
      ],
    ),
  ];
}
