import 'package:equatable/equatable.dart';

class ApiResult extends Equatable {
  final Map<String, dynamic> response;

  const ApiResult._(this.response);

  factory ApiResult.from(
    Map<String, dynamic> decodedResponse,
  ) =>
      ApiResult._(decodedResponse);

  @override
  List<Object?> get props => [response];
}
