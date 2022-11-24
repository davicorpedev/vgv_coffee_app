import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/background_image.dart';

import '../../pump_app.dart';

void main() {
  testWidgets(
    'Should find the background asset',
    (tester) async {
      await tester.pumpApp(const BackgroundImage());

      expect(
        find.image(const AssetImage('assets/background.jpeg')),
        findsOneWidget,
      );
    },
  );
}
