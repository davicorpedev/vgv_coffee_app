import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/domain/core/entities/result.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';

void main() {
  group(
    'when',
    () {
      test(
        'Should return a success when Result has been initiated as a success',
        () {
          const tString = 'test';

          final result = Result<String>.success(tString).when(
            success: (success) {
              return success;
            },
            error: (failure) {
              return failure;
            },
          );

          expect(result, tString);
        },
      );

      test(
        'Should return a failure when Result has been initiated as an error',
        () {
          final tFailure = ServerFailure();

          final result = Result<String>.error(tFailure).when(
            success: (success) {
              return success;
            },
            error: (failure) {
              return failure;
            },
          );

          expect(result, tFailure);
        },
      );

      test(
        'Should throw an Error if the value is null',
        () {
          expect(
            () => Result<String?>.success(null).when(
              success: (success) {
                return success;
              },
              error: (failure) {
                return failure;
              },
            ),
            throwsA(const TypeMatcher<StateError>()),
          );
        },
      );
    },
  );
}
