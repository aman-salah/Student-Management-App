import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppTheme().lightMode;
  ThemeData get themeData => _themeData;
  bool get isDark => _themeData == AppTheme().darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == AppTheme().lightMode) {
      themeData = AppTheme().darkMode;
    } else {
      themeData = AppTheme().lightMode;
    }
  }
}
