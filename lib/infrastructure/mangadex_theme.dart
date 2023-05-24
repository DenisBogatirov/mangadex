// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// Project imports:
import 'package:mangadex/settings/domain/user_theme.dart';

class MangaDexColors {
  static Color primary = HexColor('#ff6740');
  static Color onPrimary = HexColor('#ffffff');

  // TODO: Investigate
  static Color secondary = primary;
  static Color onSecondary = onPrimary;

  static Color darkBackground = HexColor('#111111');
  static Color darkOnBackground = HexColor('#ffffff');
  static Color lightOnBackground = const Color.fromRGBO(36, 36, 36, 1);
  static Color darkSurface = HexColor('#212328');
  static Color lightSurface = HexColor('#f0f1f2');
  static Color darkOnSurface = HexColor('#ffffff');
  static Color lightOnSurface = const Color.fromRGBO(36, 36, 36, 1);
  static Color error = HexColor('#ff5e42');

  static Color darkInputBackground = const Color.fromRGBO(61, 65, 74, 1);
  static Color lightInputBackground = const Color.fromRGBO(229, 231, 235, 1);
  static Color errorInputBackground = HexColor('#6c3c3c');

  static Color dividerColor = HexColor('#e5e7eb');
  static Color darkAccentColor = HexColor('#2c2c2c');
  static Color lightAccentColor = HexColor('#f0f1f2');

  static Color statusYellow = HexColor('#da7500');
  static Color statusRed = HexColor('#ff4040');
}

final _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: MangaDexColors.primary,
  onPrimary: MangaDexColors.onPrimary,
  secondary: MangaDexColors.secondary,
  onSecondary: MangaDexColors.onSecondary,
  error: MangaDexColors.error,
  onError: Colors.white,
  background: MangaDexColors.darkBackground,
  onBackground: MangaDexColors.darkOnBackground,
  surface: MangaDexColors.darkSurface,
  onSurface: MangaDexColors.darkOnSurface,
);

final _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: MangaDexColors.primary,
  onPrimary: MangaDexColors.onPrimary,
  secondary: MangaDexColors.secondary,
  onSecondary: MangaDexColors.onSecondary,
  error: MangaDexColors.error,
  onError: Colors.white,
  background: Colors.white,
  onBackground: MangaDexColors.lightOnBackground,
  surface: MangaDexColors.lightSurface,
  onSurface: MangaDexColors.lightOnSurface,
);

ThemeData buildTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;

  ThemeData baseTheme = ThemeData.from(
    colorScheme: isDark ? _darkColorScheme : _lightColorScheme,
  );

  final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);
  final inputBackground = MaterialStateColor.resolveWith((states) {
    if (states.contains(MaterialState.disabled)) {
      // dark theme: 5% white
      // light theme: 2% black
      switch (brightness) {
        case Brightness.dark:
          return MangaDexColors.darkInputBackground.withOpacity(0.05);
        case Brightness.light:
          return MangaDexColors.lightInputBackground.withOpacity(0.02);
      }
    }

    if (states.contains(MaterialState.error)) {
      return MangaDexColors.errorInputBackground;
    }

    switch (brightness) {
      case Brightness.dark:
        return MangaDexColors.darkInputBackground;
      case Brightness.light:
        return MangaDexColors.lightInputBackground;
    }
  });

  return baseTheme.copyWith(
      brightness: brightness,
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w800,
        ),
        labelLarge: textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: baseTheme.colorScheme.background,
          shadowColor: Colors.transparent,
          actionsIconTheme: baseTheme.iconTheme.copyWith(
            color: baseTheme.colorScheme.onBackground,
          )),
      dividerTheme: const DividerThemeData(
        color: Colors.transparent,
        space: 16.0,
        thickness: 1
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: inputBackground)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: inputBackground)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: MangaDexColors.errorInputBackground)),
        fillColor: inputBackground,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: baseTheme.colorScheme.onBackground,
        ),
      ));
}

extension ContextThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}

extension ColorSchemeExtension on ColorScheme {
  bool get isDark => brightness == Brightness.dark;
  Color get accentColor => isDark ? MangaDexColors.darkAccentColor : MangaDexColors.lightAccentColor;
}

extension UserThemeExtension on ThemeMode {
  static ThemeMode fromUserTheme(UserTheme userTheme) {
    switch (userTheme) {
      case UserTheme.dark:
        return ThemeMode.dark;
      case UserTheme.light:
        return ThemeMode.light;
      case UserTheme.slate:
      case UserTheme.system:
      default:
        return ThemeMode.system;
    }
  }
}
