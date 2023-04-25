import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';

abstract class CoffeeDataSource {
  Future<CoffeeModel> getRandomCoffee();
}

class CoffeeDataSourceImpl implements CoffeeDataSource {
  final ApiClient _client;

  CoffeeDataSourceImpl({required ApiClient client}) : _client = client;

  @override
  Future<CoffeeModel> getRandomCoffee() async {
    final result = await _client.getRandomCoffee();

    return CoffeeModel.fromJson(result.response);
  }
}
