import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/data/datasources/coffee_data_source.dart';

class DataSourceBuilder extends StatelessWidget {
  final ApiClient apiClient;
  final Widget child;

  const DataSourceBuilder({
    Key? key,
    required this.apiClient,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<CoffeeDataSource>(
          create: (context) => CoffeeDataSourceImpl(client: apiClient),
        ),
      ],
      child: child,
    );
  }
}
