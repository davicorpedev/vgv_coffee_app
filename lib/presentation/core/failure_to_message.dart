import 'package:vgv_coffee_app/domain/core/error/failures.dart';

const String serverFailureMessage = 'Server Failure';
const String networkFailureMessage = 'Network Failure';
const String invalidImageFailureMessage =
    'The image does not contain a valid format';
const String imagePermissionsFailureMessage = 'The App requires permissions';

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
        return 'Unexpected Error';
    }
  }
}
