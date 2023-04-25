import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';

void main() {
  group(
    'Result',
    () {
      group(
        'when',
        () {
          test(
            'should return a success when Result has been initiated as a success',
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
            'should return a failure when Result has been initiated as an error',
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
            'should throw an Error if the value is null',
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
    },
  );
}
