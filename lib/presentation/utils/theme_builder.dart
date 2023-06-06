import 'package:flutter/material.dart';
import 'package:vgv_coffee_app/presentation/style/app_themes.dart';

extension ThemeBuilder on AppTheme {
  ThemeData get themeData {
    return ThemeData(
      primaryColor: primary,
      brightness: brightness,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: secondary,
      ),
      textTheme: textTheme,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
        ),
      ),
    );
  }
}
