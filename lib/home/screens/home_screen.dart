// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:mangadex/auth/domain/use_cases/sign_out.use_case.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // TODO: Replace with proper stuff
          child: FilledButton(
            onPressed: () async {
              final SignOutUseCase signOutUseCase  = context.read<GetIt>().get();
              final router = context.router;

              await signOutUseCase();
              router.replaceAll([const SignInRoute()]);
            },
            child: const Text('!!SIGN OUT!!'),
          ),
        ),
      ),
    );
  }
}
