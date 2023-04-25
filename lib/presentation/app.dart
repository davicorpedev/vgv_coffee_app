import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vgv_coffee_app/config/config.dart';
import 'package:vgv_coffee_app/data/client/api_client.dart';
import 'package:vgv_coffee_app/presentation/pages/home_page.dart';
import 'package:vgv_coffee_app/presentation/repository_builder.dart';
import 'package:vgv_coffee_app/presentation/style/app_themes.dart';

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

    _apiClient = HttpApiClient(
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
        child: RepositoryBuilder(
          apiClient: _apiClient,
          child: const HomePage(),
        ),
      ),
    );
  }
}
