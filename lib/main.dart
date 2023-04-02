import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mangadex/infrastructure/di.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:provider/provider.dart';

void main() {
  configureDependencies();
  runApp(
    Provider(
      create: (_) => getIt,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter router = context.read<GetIt>().get();

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router.config(),
    );
  }
}
