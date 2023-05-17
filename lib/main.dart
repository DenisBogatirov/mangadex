// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:mangadex/infrastructure/di/di.dart';
import 'package:mangadex/infrastructure/mangadex_theme.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:mangadex/infrastructure/translations/locale_keys.g.dart';
import 'package:mangadex/theme/domain/user_theme.dart';
import 'package:mangadex/theme/theme_cubit.dart';

Future<void> main() async {
  EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning];
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          Provider(create: (_) => GetIt.instance),
          Provider<ThemeCubit>(create: (context) => context.read<GetIt>().get()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, UserTheme>(
      builder: (context, userTheme) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: buildTheme(Brightness.light),
          darkTheme: buildTheme(Brightness.dark),
          themeMode: UserThemeExtension.fromUserTheme(userTheme),
          routerConfig: AppRouter.instance.config(),
          onGenerateTitle: (context) => LocaleKeys.appName.tr(),
        );
      },
    );
  }
}
