import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/data/client/api_result.dart';
import 'package:vgv_coffee_app/data/error/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const baseUrl = 'baseUrl';
  const path = 'path';

  const jsonKey = 'test';
  const jsonValue = 'test';

  late final LiveApiClient apiClient;
  late final MockHttpClient httpClient;

  setUpAll(() {
    httpClient = MockHttpClient();

    apiClient = LiveApiClient(
      client: httpClient,
      baseUrl: baseUrl,
    );

    registerFallbackValue(Uri());
  });

  group(
    'get',
    () {
      test(
        'Should perform a HTTP GET request',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('{}', 200),
          );

          await apiClient.get(path: path);

          verify(
            () => httpClient.get(
              Uri.https(baseUrl, '/$path'),
            ),
          ).called(1);
        },
      );

      test(
        'Should return an ApiResponse if the response is successful',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('{"$jsonKey": "$jsonValue"}', 200),
          );

          final result = await apiClient.get(path: path);

          expect(
            result,
            ApiResult.from(const {jsonKey: jsonValue}),
          );
        },
      );

      test(
        'Should throw a ServerException if the request has failed',
        () async {
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('{}', 404),
          );

          final call = apiClient.get(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );

      test(
        'Should throw a ServerException if the request has an unexpected error',
        () async {
          when(() => httpClient.get(any())).thenThrow(
            TimeoutException(''),
          );

          final call = apiClient.get(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );
    },
  );
}
