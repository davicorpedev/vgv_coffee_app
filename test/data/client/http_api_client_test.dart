import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/data/error/exceptions.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const baseUrl = 'baseUrl';

  late final HttpApiClient apiClient;
  late final MockHttpClient httpClient;

  setUpAll(() {
    httpClient = MockHttpClient();

    apiClient = HttpApiClient(
      client: httpClient,
      baseUrl: baseUrl,
    );

    registerFallbackValue(Uri());
  });

  group(
    'getRandomCoffee',
    () {
      const tCoffeeModel = CoffeeModel(url: 'https://test.test/test.png');

      test(
        'should perform a HTTP GET request',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response(
              fixture('coffee.json'),
              200,
            ),
          );

          await apiClient.getRandomCoffee();

          verify(
            () => httpClient.get(
              Uri.https(baseUrl, '/random.json'),
            ),
          ).called(1);
        },
      );

      test(
        'should return a CoffeeModel if the response is successful',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response(
              fixture('coffee.json'),
              200,
            ),
          );

          final result = await apiClient.getRandomCoffee();

          expect(result, tCoffeeModel);
        },
      );

      test(
        'should throw a ServerException if the request has failed',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('{}', 404),
          );

          final call = apiClient.getRandomCoffee();

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );

      test(
        'should throw a ServerException if the request has an unexpected error',
        () async {
          when(() => httpClient.get(any())).thenThrow(
            TimeoutException(''),
          );

          final call = apiClient.getRandomCoffee();

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );
    },
  );
}
