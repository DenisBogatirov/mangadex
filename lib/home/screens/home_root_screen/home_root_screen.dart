// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:mangadex/home/screens/home_root_screen/widgets/popular_manga_cubit/popular_manga_cubit.dart';
import 'widgets/popular_manga_cubit/popular_manga.dart';

@RoutePage()
class HomeRootScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeRootScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMangaCubit>(create: (context) => context.read<GetIt>().get()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PopularManga(),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Placeholder(),
        )
      ],
    );
  }
}