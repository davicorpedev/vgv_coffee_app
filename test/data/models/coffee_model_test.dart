import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const tCoffeeModel = CoffeeModel(url: 'https://test.test/test.png');

  group(
    'CofeeModel',
    () {
      test(
        'should be a subclass of Coffee',
        () {
          expect(tCoffeeModel, isA<Coffee>());
        },
      );

      group(
        'fromJson',
        () {
          test(
            'Should return a valid object',
            () {
              final Map<String, dynamic> jsonMap = json.decode(
                fixture('coffee.json'),
              );

              final result = CoffeeModel.fromJson(jsonMap);

              expect(result, tCoffeeModel);
            },
          );
        },
      );
    },
  );
}
