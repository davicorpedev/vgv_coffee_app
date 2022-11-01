import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/app_info.dart';

import '../pump_app.dart';

void main() {
  testWidgets(
    'Should find the AppInfo labels',
    (tester) async {
      await tester.pumpApp(const AppInfo());

      expect(find.text('☕'), findsOneWidget);
      expect(find.text('Very Good Coffee App'), findsOneWidget);
      expect(find.text('Start your day with a lovely coffee~'), findsOneWidget);
    },
  );
}
