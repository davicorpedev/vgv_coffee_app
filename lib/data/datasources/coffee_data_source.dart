import 'package:vgv_coffee_app/data/core/client/api_client.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';

abstract class CoffeeDataSource {
  Future<CoffeeModel> getRandomCoffee();
}

class CoffeeDataSourceImpl extends CoffeeDataSource {
  final ApiClient _client;

  CoffeeDataSourceImpl({required ApiClient client}) : _client = client;

  @override
  Future<CoffeeModel> getRandomCoffee() async {
    final result = await _client.get(path: 'random.json');

    return CoffeeModel.fromJson(result.response);
  }
}
