// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'widgets/popular_manga/popular_manga.dart';
import 'widgets/popular_manga/popular_manga_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMangaCubit>(
          create: (context) => context.read<GetIt>().get()
            ..subscribeToContentRating(
              context.read(),
            ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollController>(builder: (context, controller, _) {
      return CustomScrollView(
        controller: controller,
        slivers: const [
          // SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
          SliverToBoxAdapter(child: PopularManga()),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Placeholder(),
          ),
          SliverToBoxAdapter(child: Placeholder(fallbackHeight: 200)),
          SliverToBoxAdapter(child: Placeholder(fallbackHeight: 200)),
        ],
      );
    });
  }
}
