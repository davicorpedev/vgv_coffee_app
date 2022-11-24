import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/presentation/widgets/reload_image_button.dart';

import '../mocks/mock_coffe_cubit.dart';
import '../pump_app.dart';

void main() {
  late MockCoffeeCubit coffeeCubit;

  setUpAll(() {
    registerFallbackValue(CoffeeStateFake());
  });

  setUp(
    () {
      coffeeCubit = MockCoffeeCubit();
    },
  );

  testWidgets(
    'Should find a Reload new Image Label',
    (tester) async {
      await tester.pumpApp(const ReloadImageButton());

      expect(find.text('Reload new Image'), findsOneWidget);
    },
  );

  testWidgets(
    'Should call reloadCoffe on tapping Reload new Image Button',
    (tester) async {
      await tester.pumpApp(
        BlocProvider<CoffeeCubit>(
          create: (context) => coffeeCubit,
          child: const ReloadImageButton(),
        ),
      );

      await tester.tap(find.text('Reload new Image'));

      verify(() => coffeeCubit.reloadCoffee()).called(1);
    },
  );
}
