import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  final CoffeeRepository _repository;

  CoffeeCubit({
    required CoffeeRepository repository,
  })  : _repository = repository,
        super(CoffeeLoadingState());

  void getInitialCoffee() {
    _getRandomCoffee();
  }

  void reloadCoffee() {
    emit(CoffeeLoadingState());

    _getRandomCoffee();
  }

  Future<void> _getRandomCoffee() async {
    final result = await _repository.getRandomCoffee();

    result.when(
      success: (coffee) {
        emit(CoffeeLoadedState(coffee));
      },
      error: (failure) {
        emit(CoffeeErrorState(failure));
      },
    );
  }
}
