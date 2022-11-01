import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vgv_coffee_app/data/core/client/api_client.dart';
import 'package:vgv_coffee_app/config/config.dart';
import 'package:vgv_coffee_app/presentation/core/app_themes.dart';
import 'package:vgv_coffee_app/presentation/data_source_builder.dart';
import 'package:vgv_coffee_app/presentation/pages/home_page.dart';
import 'package:vgv_coffee_app/presentation/repository_builder.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();

    _apiClient = LiveApiClient(
      client: http.Client(),
      baseUrl: coffeeApiBaseUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Very Good Coffee App',
      theme: AppThemes.appTheme,
      home: Provider.value(
        value: _apiClient,
        child: DataSourceBuilder(
          apiClient: _apiClient,
          child: const RepositoryBuilder(
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
