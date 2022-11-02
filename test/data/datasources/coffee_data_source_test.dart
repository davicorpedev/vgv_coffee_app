import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/data/core/client/api_result.dart';
import 'package:vgv_coffee_app/data/core/error/exceptions.dart';
import 'package:vgv_coffee_app/data/datasources/coffee_data_source.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';

import '../../fixtures/fixture_reader.dart';
import '../utils/mock_api_client.dart';

void main() {
  late MockApiClient client;
  late CoffeeDataSource dataSource;

  setUp(() {
    client = MockApiClient();
    dataSource = CoffeeDataSourceImpl(client: client);
  });

  group(
    'getRandomCoffee',
    () {
      const tCoffeeModel = CoffeeModel(url: 'https://test.test/test.png');

      test(
        'Should perform a get request',
        () async {
          when(() => client.get(path: any(named: 'path'))).thenAnswer(
            (_) async => ApiResult.from(json.decode(fixture('coffee.json'))),
          );

          dataSource.getRandomCoffee();

          verify(() => client.get(path: 'random.json')).called(1);
        },
      );

      test(
        'Should return a Coffee when the request is successful',
        () async {
          when(() => client.get(path: any(named: 'path'))).thenAnswer(
            (_) async => ApiResult.from(json.decode(fixture('coffee.json'))),
          );

          final result = await dataSource.getRandomCoffee();

          verify(() => client.get(path: 'random.json')).called(1);
          expect(result, tCoffeeModel);
        },
      );

      test(
        'Should throw a ServerException when the response fails',
        () async {
          when(() => client.get(path: any(named: 'path'))).thenThrow(
            ServerException(),
          );

          final call = dataSource.getRandomCoffee();

          expect(() => call, throwsA(const TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
