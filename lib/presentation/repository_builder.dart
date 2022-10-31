import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:vgv_coffee_app/data/datasources/coffee_data_source.dart';
import 'package:vgv_coffee_app/domain/core/utils/network_info.dart';
import 'package:vgv_coffee_app/domain/core/utils/vgv_image_downloader.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';

class RepositoryBuilder extends StatelessWidget {
  final Widget child;

  const RepositoryBuilder({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<CoffeeRepository>(
          create: (context) => CoffeeRepositoryImpl(
            dataSource: RepositoryProvider.of<CoffeeDataSource>(context),
            networkInfo: NetworkInfo(
              connectionChecker: InternetConnectionChecker(),
            ),
          ),
        ),
        RepositoryProvider<ImageRepository>(
          create: (context) => ImageRepositoryImpl(
            imageDownloader: VGVImageDownloader(),
            networkInfo: NetworkInfo(
              connectionChecker: InternetConnectionChecker(),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
