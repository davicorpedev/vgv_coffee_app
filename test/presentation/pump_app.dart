import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/presentation/core/app_themes.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget child,
  ) {
    return pumpWidget(
      MaterialApp(
        theme: AppThemes.appTheme,
        home: child,
      ),
    );
  }
}
