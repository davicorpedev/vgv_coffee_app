import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/app_info.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/background_image.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/coffee_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CoffeeCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = CoffeeCubit(
      repository: RepositoryProvider.of<CoffeeRepository>(context),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();

    context.read<CoffeeCubit>().getInitialCoffee();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Column(
                children: [
                  SizedBox(height: 32),
                  AppInfo(),
                  SizedBox(height: 48),
                  Expanded(child: CoffeeImage()),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
