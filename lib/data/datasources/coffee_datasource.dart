import 'package:vgv_coffee_app/domain/entities/coffee.dart';

abstract class CoffeeDataSource {
  Future<Coffee> getRandomCoffee();
}
