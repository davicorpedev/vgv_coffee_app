import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late MockCoffeeRepository repository;

  setUp(() {
    repository = MockCoffeeRepository();
  });

  blocTest<CoffeeCubit, CoffeeState>(
    'Initial state should be CoffeeLoadingState',
    build: () => CoffeeCubit(repository: repository),
    verify: (cubit) {
      expect(cubit.state, CoffeeLoadingState());
    },
  );

  const tCoffee = Coffee(url: 'https://test.test/test.png');
  final tFailure = ServerFailure();

  group(
    'getInitialCoffee',
    () {
      blocTest<CoffeeCubit, CoffeeState>(
        'Should call getRandomCoffee from repository',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.success(tCoffee),
          );
        },
        act: (bloc) => bloc.getInitialCoffee(),
        verify: (cubit) {
          verify(() => repository.getRandomCoffee()).called(1);
        },
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'Should emit [CoffeeLoadedState] if the repository returns success',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.success(tCoffee),
          );
        },
        act: (bloc) => bloc.getInitialCoffee(),
        expect: () {
          return [
            const CoffeeLoadedState(tCoffee),
          ];
        },
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'Should emit [CoffeeErrorState] if the repository returns error',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.error(tFailure),
          );
        },
        act: (bloc) => bloc.getInitialCoffee(),
        expect: () {
          return [
            CoffeeErrorState(tFailure),
          ];
        },
      );
    },
  );

  group(
    'reloadCoffee',
    () {
      blocTest<CoffeeCubit, CoffeeState>(
        'Should call getRandomCoffee from repository',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.success(tCoffee),
          );
        },
        seed: () => const CoffeeLoadedState(tCoffee),
        act: (bloc) => bloc.reloadCoffee(),
        verify: (cubit) {
          verify(() => repository.getRandomCoffee()).called(1);
        },
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'Should emit [CoffeeLoadingState, CoffeeLoadedState] if the repository returns success',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.success(tCoffee),
          );
        },
        seed: () => const CoffeeLoadedState(tCoffee),
        act: (bloc) => bloc.reloadCoffee(),
        expect: () {
          return [
            CoffeeLoadingState(),
            const CoffeeLoadedState(tCoffee),
          ];
        },
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'Should emit [CoffeeLoadingState, CoffeeErrorState] if the repository returns error',
        build: () => CoffeeCubit(repository: repository),
        setUp: () {
          when(() => repository.getRandomCoffee()).thenAnswer(
            (_) async => Result.error(tFailure),
          );
        },
        seed: () => const CoffeeLoadedState(tCoffee),
        act: (bloc) => bloc.reloadCoffee(),
        expect: () {
          return [
            CoffeeLoadingState(),
            CoffeeErrorState(tFailure),
          ];
        },
      );
    },
  );
}
