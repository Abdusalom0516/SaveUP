import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static AppColors colors = AppColors();
  // LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: colors.purple,
      primary: colors.primaryLight,
      secondary: colors.mutedForegroundLight,
      surface: colors.backgroundLight,
      tertiary: colors.accentLight,
      outline: colors.borderLight,
      primaryContainer: colors.cardLight,
    ),
    scaffoldBackgroundColor: colors.backgroundLight,
    cardColor: colors.cardLight,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colors.cardLight,
      foregroundColor: colors.backgroundDark,
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: colors.purple,
      primary: colors.primaryDark,
      secondary: colors.mutedForegroundDark,
      surface: colors.backgroundDark,
      tertiary: colors.accentDark,
      outline: colors.borderDark,
      primaryContainer: colors.cardDark,
    ),
    scaffoldBackgroundColor: colors.backgroundDark,
    cardColor: colors.cardDark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colors.cardDark,
      foregroundColor: colors.white,
    ),
  );
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
}
