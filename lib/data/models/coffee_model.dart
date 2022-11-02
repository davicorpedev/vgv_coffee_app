import 'package:vgv_coffee_app/domain/entities/coffee.dart';

class CoffeeModel extends Coffee {
  const CoffeeModel({required String url}) : super(url: url);

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      url: json['file'],
    );
  }
}
