import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';
import 'package:vgv_coffee_app/presentation/pages/home_page.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/app_info.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/background_image.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/coffee_image.dart';

import '../../../application/coffee_cubit_test.dart';
import '../../../application/download_image_test.dart';
import '../../mocks/mock_coffe_cubit.dart';
import '../../pump_app.dart';

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
    'Should find the HomePageBody Widget',
    (tester) async {
      final coffeeRepository = MockCoffeeRepository();

      when(() => coffeeRepository.getRandomCoffee()).thenAnswer(
        (_) async => Result.success(const Coffee(url: 'test')),
      );

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<ImageRepository>.value(
              value: MockImageRepository(),
            ),
            RepositoryProvider<CoffeeRepository>.value(
              value: coffeeRepository,
            ),
          ],
          child: const HomePage(),
        ),
      );

      expect(find.byType(HomePageBody), findsOneWidget);
    },
  );

  testWidgets(
    'Should call getInitialCoffee when initiating the Widget',
    (tester) async {
      when(() => coffeeCubit.state).thenReturn(
        CoffeeLoadingState(),
      );

      await tester.pumpApp(
        BlocProvider<CoffeeCubit>.value(
          value: coffeeCubit,
          child: RepositoryProvider<ImageRepository>.value(
            value: MockImageRepository(),
            child: const HomePageBody(),
          ),
        ),
      );

      verify((() => coffeeCubit.getInitialCoffee())).called(1);
    },
  );

  testWidgets(
    'Should find the BackgroundImage, AppInfo and CoffeeImage Widgets',
    (tester) async {
      when(() => coffeeCubit.state).thenReturn(
        CoffeeLoadingState(),
      );

      await tester.pumpApp(
        BlocProvider<CoffeeCubit>.value(
          value: coffeeCubit,
          child: RepositoryProvider<ImageRepository>.value(
            value: MockImageRepository(),
            child: const HomePageBody(),
          ),
        ),
      );

      expect(find.byType(BackgroundImage), findsOneWidget);
      expect(find.byType(AppInfo), findsOneWidget);
      expect(find.byType(CoffeeImage), findsOneWidget);
    },
  );
}
