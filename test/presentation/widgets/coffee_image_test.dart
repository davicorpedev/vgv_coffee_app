import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';
import 'package:vgv_coffee_app/presentation/utils/map_failure_to_message.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/coffee_image.dart';
import 'package:vgv_coffee_app/presentation/widgets/download_image_button.dart';
import 'package:vgv_coffee_app/presentation/widgets/reload_image_button.dart';

import '../../application/download_image_test.dart';
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

  const tCoffee = Coffee(url: 'test.test.jpg');
  final tFailure = ServerFailure();

  testWidgets(
    'Should find a DownloadImageButton, ReloadImageButton and Image Widgets if the state is CoffeeLoadedState',
    (tester) async {
      mockNetworkImagesFor(
        () async {
          when(() => coffeeCubit.state).thenReturn(
            const CoffeeLoadedState(tCoffee),
          );

          await tester.pumpApp(
            BlocProvider<CoffeeCubit>.value(
              value: coffeeCubit,
              child: RepositoryProvider<ImageRepository>.value(
                value: MockImageRepository(),
                child: const CoffeeImage(),
              ),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(DownloadImageButton), findsOneWidget);
          expect(find.byType(ReloadImageButton), findsOneWidget);
          expect(find.image(NetworkImage(tCoffee.url)), findsOneWidget);
        },
      );
    },
  );

  testWidgets(
    'Should find a CircularProgressIndicator if the state is CoffeeLoadingState',
    (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeLoadingState());

      await tester.pumpApp(
        BlocProvider<CoffeeCubit>.value(
          value: coffeeCubit,
          child: RepositoryProvider<ImageRepository>.value(
            value: MockImageRepository(),
            child: const CoffeeImage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Should find an error message, an icon and a label if the state is CoffeeErrorState',
    (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeErrorState(tFailure));

      await tester.pumpApp(
        BlocProvider<CoffeeCubit>.value(
          value: coffeeCubit,
          child: RepositoryProvider<ImageRepository>.value(
            value: MockImageRepository(),
            child: const CoffeeImage(),
          ),
        ),
      );

      expect(find.text(tFailure.mapFailureToMessage), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    },
  );

  testWidgets(
    'Should call reloadCoffee on tapping the Try Again Button',
    (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeErrorState(tFailure));
      when((() => coffeeCubit.reloadCoffee())).thenAnswer(
        (_) async => () {},
      );

      await tester.pumpApp(
        BlocProvider<CoffeeCubit>.value(
          value: coffeeCubit,
          child: RepositoryProvider<ImageRepository>.value(
            value: MockImageRepository(),
            child: const CoffeeImage(),
          ),
        ),
      );

      await tester.tap(find.text('Try Again'));

      verify(() => coffeeCubit.reloadCoffee()).called(1);
    },
  );
}
