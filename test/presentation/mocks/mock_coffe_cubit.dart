import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

class CoffeeStateFake extends Fake implements CoffeeState {}
