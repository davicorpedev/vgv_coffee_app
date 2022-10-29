import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/data/datasources/coffee_data_source.dart';
import 'package:vgv_coffee_app/data/core/error/exceptions.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';
import 'package:vgv_coffee_app/domain/core/entities/result.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';

import '../utils/mock_network_info.dart';

class MockCoffeeDataSource extends Mock implements CoffeeDataSource {}

void main() {
  late MockCoffeeDataSource dataSource;
  late MockNetworkInfo networkInfo;
  late CoffeeRepository repository;

  setUp(
    () {
      networkInfo = MockNetworkInfo();
      dataSource = MockCoffeeDataSource();
      repository = CoffeeRepositoryImpl(
        dataSource: dataSource,
        networkInfo: networkInfo,
      );
    },
  );

  group(
    'getRandomCoffee',
    () {
      const tCoffeeModel = CoffeeModel(url: 'https://test.test/test.png');
      const Coffee tCoffee = tCoffeeModel;

      group(
        'Online',
        () {
          setUp(
            () {
              networkInfo.runTestsOnline();
            },
          );

          test(
            'Should check if the device has internet connection',
            () async {
              when((() => dataSource.getRandomCoffee())).thenAnswer(
                (_) async => tCoffeeModel,
              );

              repository.getRandomCoffee();

              verify(() => networkInfo.isConnected).called(1);
            },
          );

          test(
            'Should return a valid model when call is successful',
            () async {
              when((() => dataSource.getRandomCoffee())).thenAnswer(
                (_) async => tCoffeeModel,
              );

              final result = await repository.getRandomCoffee();

              verify(() => dataSource.getRandomCoffee()).called(1);
              expect(
                result,
                Result<Coffee>.success(tCoffee),
              );
            },
          );

          test(
            'Should return ServerFailure when the request has failed',
            () async {
              when((() => dataSource.getRandomCoffee())).thenThrow(
                ServerException(),
              );

              final result = await repository.getRandomCoffee();

              verify(() => dataSource.getRandomCoffee()).called(1);
              expect(
                result,
                Result<Coffee>.error(ServerFailure()),
              );
            },
          );
        },
      );

      group(
        'Offline',
        () {
          setUp(
            () {
              networkInfo.runTestsOffline();
            },
          );

          test(
            'Should return NetworkFailure when the user has no connection',
            () async {
              final result = await repository.getRandomCoffee();

              verifyNever(() => dataSource.getRandomCoffee());
              expect(
                result,
                Result<Coffee>.error(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );
}
