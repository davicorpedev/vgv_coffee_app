import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/presentation/style/app_themes.dart';
import 'package:vgv_coffee_app/presentation/utils/theme_builder.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget child,
  ) {
    return pumpWidget(
      MaterialApp(
        theme: LightTheme().themeData,
        home: child,
      ),
    );
  }
}
