// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:mangadex/infrastructure/router/user_drawer_router.dart';
import 'package:mangadex/widgets/drawer_container.dart';
import 'widgets/mangadex_app_bar.dart';

@RoutePage()
class HomeRootScreen extends StatefulWidget {
  const HomeRootScreen({
    super.key,
  });

  @override
  State<HomeRootScreen> createState() => _HomeRootScreenState();
}

class _HomeRootScreenState extends State<HomeRootScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _drawerRouter = UserDrawerRouter.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerEdgeDragWidth: 0,
      drawer: const DrawerContainer(
        child: SafeArea(
          child: Placeholder(),
        ),
      ),
      endDrawer: DrawerContainer(
        child: Router.withConfig(
          restorationScopeId: 'user_drawer_router_id',
          config: _drawerRouter.config(),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: const MangaDexAppBar(),
            )
          ];
        },
        body: const AutoRouter(),
      ),
    );
  }
}
