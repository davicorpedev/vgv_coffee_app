import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';
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
    )..getInitialCoffee();
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
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: const [
                Text('Very Good Coffee App'),
                Text('Start your day with a lovely coffee~'),
                CoffeeImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
