import 'package:equatable/equatable.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';

class Result<T> extends Equatable {
  final T? _value;
  final Failure? _error;

  const Result._({
    required T? value,
    required Failure? error,
  })  : _value = value,
        _error = error;

  factory Result.success(T value) => Result._(
        value: value,
        error: null,
      );
  factory Result.error(Failure failure) => Result._(
        value: null,
        error: failure,
      );

  Result<T> when({
    required Result<T> Function(T value) success,
    required Result<T> Function(Failure error) error,
  }) {
    if (_value != null) {
      return success(_value!);
    } else if (_error != null) {
      return error(_error!);
    }

    throw Exception('Unhandled case');
  }

  @override
  List<Object?> get props => [_value, _error];
}
