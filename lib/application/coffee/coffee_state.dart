part of 'coffee_cubit.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object> get props => [];
}

class CoffeeLoadingState extends CoffeeState {}

class CoffeeLoadedState extends CoffeeState {
  final Coffee coffee;

  const CoffeeLoadedState(this.coffee);

  @override
  List<Object> get props => [coffee];
}

class CoffeeErrorState extends CoffeeState {
  final Failure failure;

  const CoffeeErrorState(this.failure);

  @override
  List<Object> get props => [failure];
}
