// import 'package:flutter/material.dart';
// import 'package:rhythm/themes/dark_mode.dart';
// import 'package:rhythm/themes/light_mode.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   // Initially, light mode
//   ThemeData _themeData = lightMode;
//
//   // Get current theme
//   ThemeData get themeData => _themeData;
//
//   // Check if dark mode is active
//   bool get isDarkMode => _themeData == darkMode;
//
//   // Set theme
//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//
//     // Notify UI to rebuild
//     notifyListeners();
//   }
//
//   // Toggle between light and dark mode
//   void toggleTheme() {
//     if (_themeData == lightMode) {
//       themeData = darkMode; // Assign dark mode
//     } else {
//       themeData = lightMode; // Assign light mode
//     }
//   }
// }








import 'package:cricklyzer/themes/dark_mode.dart';
import 'package:cricklyzer/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier {
  static const String THEME_KEY = 'theme_mode';
  ThemeData _themeData = lightMode;
  late SharedPreferences _prefs;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Get current theme
  ThemeData get themeData => _themeData;

  // Check if dark mode is active
  bool get isDarkMode => _themeData == darkMode;

  // Load theme from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final bool isDark = _prefs.getBool(THEME_KEY) ?? false;
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  // Save theme to SharedPreferences
  Future<void> _saveThemeToPrefs(bool isDark) async {
    await _prefs.setBool(THEME_KEY, isDark);
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
      _saveThemeToPrefs(true);
    } else {
      _themeData = lightMode;
      _saveThemeToPrefs(false);
    }
    notifyListeners();
  }
}