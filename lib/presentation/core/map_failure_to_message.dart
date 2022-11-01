import 'package:vgv_coffee_app/domain/core/error/failures.dart';

const String serverFailureMessage =
    'There has been an error while trying to connect to the server';
const String networkFailureMessage =
    'There is something wrong with your internet connection';
const String invalidImageFailureMessage =
    'This image does not contain a valid format';
const String imagePermissionsFailureMessage =
    'The App requires photo library permissions to download images';
const String tUnhandledFailure = 'Unhandled Failure';

extension Message on Failure {
  String get mapFailureToMessage {
    switch (runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case NetworkFailure:
        return networkFailureMessage;
      case InvalidImageFailure:
        return invalidImageFailureMessage;
      case ImagePermissionsFailure:
        return imagePermissionsFailureMessage;
      default:
        return tUnhandledFailure;
    }
  }
}
