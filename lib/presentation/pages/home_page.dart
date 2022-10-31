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
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
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
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/background.jpeg',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
      color: Colors.black.withOpacity(0.8),
      colorBlendMode: BlendMode.hardLight,
    );
  }
}

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          '☕',
          style: TextStyle(fontSize: 62),
        ),
        Text(
          'Very Good Coffee App',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 32),
        Text(
          'Start your day with a lovely coffee~',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
