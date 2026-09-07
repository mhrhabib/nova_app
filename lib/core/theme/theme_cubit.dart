import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _key = 'user_theme_mode';
  final SharedPreferences prefs;

  ThemeCubit(this.prefs) : super(ThemeMode.system) {
    _loadSavedTheme();
  }

  void _loadSavedTheme() {
    final savedValue = prefs.getString(_key);
    if (savedValue == 'light') {
      emit(ThemeMode.light);
    } else if (savedValue == 'dark') {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.system);
    }
  }

  Future<void> toggleTheme(ThemeMode mode) async {
    emit(mode);
    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_key, 'light');
        break;
      case ThemeMode.dark:
        await prefs.setString(_key, 'dark');
        break;
      case ThemeMode.system:
        await prefs.remove(_key);
        break;
    }
  }
}
