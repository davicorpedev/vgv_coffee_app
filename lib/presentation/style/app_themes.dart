import 'package:flutter/material.dart';

class AppThemes {
  static final appTheme = ThemeData(
    primaryColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.white,
      secondary: Colors.black,
    ),
    textTheme: const TextTheme(
      headline4: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      button: TextStyle(color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
  );
}
