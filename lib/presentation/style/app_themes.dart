import 'package:flutter/material.dart';

abstract class AppTheme {
  late final Color primary;
  late final Color secondary;
  late final TextTheme textTheme;
  late final Brightness brightness;
}

class LightTheme implements AppTheme {
  @override
  Color primary = Colors.white;

  @override
  Color secondary = Colors.black;

  @override
  TextTheme textTheme = Typography().white;

  @override
  Brightness brightness = Brightness.light;
}
