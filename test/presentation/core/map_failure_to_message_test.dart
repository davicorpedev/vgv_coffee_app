import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/presentation/core/map_failure_to_message.dart';

void main() {
  group(
    'mapFailureToMessage',
    () {
      test(
        'should return a Server Failure message',
        () {
          final tFailure = ServerFailure();

          expect(
            tFailure.mapFailureToMessage,
            serverFailureMessage,
          );
        },
      );

      test(
        'should return a Network Failure message',
        () {
          final tFailure = NetworkFailure();

          expect(
            tFailure.mapFailureToMessage,
            networkFailureMessage,
          );
        },
      );

      test(
        'should return a Invalid Image Failure message',
        () {
          final tFailure = InvalidImageFailure();

          expect(
            tFailure.mapFailureToMessage,
            invalidImageFailureMessage,
          );
        },
      );

      test(
        'should return a Image Permissions Failure message',
        () {
          final tFailure = ImagePermissionsFailure();

          expect(
            tFailure.mapFailureToMessage,
            imagePermissionsFailureMessage,
          );
        },
      );

      test(
        'should return a Unhandled Failure message',
        () {
          final tFailure = UnimplementedFailure();

          expect(
            tFailure.mapFailureToMessage,
            tUnhandledFailure,
          );
        },
      );
    },
  );
}
