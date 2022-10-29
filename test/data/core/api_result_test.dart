import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/data/core/client/api_result.dart';

void main() {
  const tMap = {'test': 'test'};

  group('from', () {
    test(
      'should return a valid object',
      () async {
        final result = ApiResult.from(tMap);

        expect(result.response, tMap);
      },
    );
  });
}
