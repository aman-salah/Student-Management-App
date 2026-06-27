import 'package:flutter/material.dart';

class AppTheme {
  //light mode
  ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: const Color.fromARGB(255, 212, 210, 210),
    ),
  );

  //dark mode
  ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255, 62, 62, 62),
    ),
  );
}
