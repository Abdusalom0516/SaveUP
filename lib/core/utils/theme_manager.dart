import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManagerCubit extends Cubit<ThemeMode> {
  static const _themeKey = 'theme_mode';

  ThemeManagerCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex != null) {
      emit(ThemeMode.values[themeIndex]);
    }
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setLightTheme() async {
    emit(ThemeMode.light);
    await _saveTheme(ThemeMode.light);
  }

  Future<void> setDarkTheme() async {
    emit(ThemeMode.dark);
    await _saveTheme(ThemeMode.dark);
  }

  Future<void> setSystemTheme() async {
    emit(ThemeMode.system);
    await _saveTheme(ThemeMode.system);
  }
}
