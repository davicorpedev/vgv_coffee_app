import 'dart:async';

import 'package:vgv_coffee_app/data/datasources/coffee_datasource.dart';
import 'package:vgv_coffee_app/data/datasources/core/error/exceptions.dart';
import 'package:vgv_coffee_app/domain/core/entities/result.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/core/utils/network_info.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';

abstract class CoffeeRepository {
  Future<Result<Coffee>> getRandomCoffee();
}

class CoffeeRepositoryImpl extends CoffeeRepository {
  final CoffeeDataSource _dataSource;
  final NetworkInfo _networkInfo;

  CoffeeRepositoryImpl({
    required CoffeeDataSource dataSource,
    required NetworkInfo networkInfo,
  })  : _dataSource = dataSource,
        _networkInfo = networkInfo;

  @override
  Future<Result<Coffee>> getRandomCoffee() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _dataSource.getRandomCoffee();

        return Result.success(result);
      } on ServerException {
        return Result.error(ServerFailure());
      }
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
