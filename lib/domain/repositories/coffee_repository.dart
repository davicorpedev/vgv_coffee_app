import 'dart:async';

import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/data/error/exceptions.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/utils/network_info.dart';

abstract class CoffeeRepository {
  Future<Result<Coffee>> getRandomCoffee();
}

class CoffeeRepositoryImpl implements CoffeeRepository {
  final ApiClient _apiClient;
  final NetworkInfo _networkInfo;

  CoffeeRepositoryImpl({
    required ApiClient apiClient,
    required NetworkInfo networkInfo,
  })  : _apiClient = apiClient,
        _networkInfo = networkInfo;

  @override
  Future<Result<Coffee>> getRandomCoffee() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _apiClient.getRandomCoffee();

        return Result.success(result);
      } on ServerException {
        return Result.error(ServerFailure());
      }
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
