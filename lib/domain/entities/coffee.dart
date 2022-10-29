import 'package:equatable/equatable.dart';

class Coffee extends Equatable {
  final String url;

  const Coffee({required this.url});

  @override
  List<Object?> get props => [url];
}
