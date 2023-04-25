import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/data/error/exceptions.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';

import '../../data/utils/mock_api_client.dart';
import '../utils/mock_network_info.dart';

void main() {
  late MockApiClient apiClient;
  late MockNetworkInfo networkInfo;
  late CoffeeRepository repository;

  setUp(
    () {
      networkInfo = MockNetworkInfo();
      apiClient = MockApiClient();
      repository = CoffeeRepositoryImpl(
        apiClient: apiClient,
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
        'online',
        () {
          setUp(
            () {
              networkInfo.runTestsOnline();
            },
          );

          test(
            'should check if the device has internet connection',
            () async {
              when((() => apiClient.getRandomCoffee())).thenAnswer(
                (_) async => tCoffeeModel,
              );

              repository.getRandomCoffee();

              verify(() => networkInfo.isConnected).called(1);
            },
          );

          test(
            'should return a valid model when call is successful',
            () async {
              when((() => apiClient.getRandomCoffee())).thenAnswer(
                (_) async => tCoffeeModel,
              );

              final result = await repository.getRandomCoffee();

              verify(() => apiClient.getRandomCoffee()).called(1);
              expect(
                result,
                Result<Coffee>.success(tCoffee),
              );
            },
          );

          test(
            'should return ServerFailure when the request has failed',
            () async {
              when((() => apiClient.getRandomCoffee())).thenThrow(
                ServerException(),
              );

              final result = await repository.getRandomCoffee();

              verify(() => apiClient.getRandomCoffee()).called(1);
              expect(
                result,
                Result<Coffee>.error(ServerFailure()),
              );
            },
          );
        },
      );

      group(
        'offline',
        () {
          setUp(
            () {
              networkInfo.runTestsOffline();
            },
          );

          test(
            'should return NetworkFailure when the user has no connection',
            () async {
              final result = await repository.getRandomCoffee();

              verifyNever(() => apiClient.getRandomCoffee());
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
