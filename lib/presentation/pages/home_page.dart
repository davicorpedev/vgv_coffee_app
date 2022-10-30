import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/repositories/coffee_repository.dart';

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
          child: Column(
            children: [
              Text('Very Good Coffee App'),
              Text('Start your day with a lovely coffee~'),
              BlocBuilder<CoffeeCubit, CoffeeState>(
                builder: (context, state) {
                  if (state is CoffeeErrorState) {
                    return HomePageError(failure: state.failure);
                  } else if (state is CoffeeLoadedState) {
                    return HomePageLoaded(coffee: state.coffee);
                  }

                  return const HomePageLoading();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageLoaded extends StatelessWidget {
  final Coffee coffee;

  const HomePageLoaded({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(coffee.url),
        ),
        TextButton(
          onPressed: () {
            context.read<CoffeeCubit>().reloadCoffee();
          },
          child: Text('reload'),
        ),
      ],
    );
  }
}

class HomePageLoading extends StatelessWidget {
  const HomePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class HomePageError extends StatelessWidget {
  final Failure failure;

  const HomePageError({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Text('failure');
  }
}
