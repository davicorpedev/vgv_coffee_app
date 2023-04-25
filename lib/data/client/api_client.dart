import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vgv_coffee_app/data/error/exceptions.dart';
import 'package:vgv_coffee_app/data/models/coffee_model.dart';

abstract class ApiClient {
  Future<CoffeeModel> getRandomCoffee();
}

class HttpApiClient implements ApiClient {
  final http.Client _client;
  final String _baseUrl;

  HttpApiClient({
    required http.Client client,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl;

  @override
  Future<CoffeeModel> getRandomCoffee() async {
    try {
      final uri = Uri.https(_baseUrl, '/random.json');

      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        return CoffeeModel.fromJson(decodedResponse);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
