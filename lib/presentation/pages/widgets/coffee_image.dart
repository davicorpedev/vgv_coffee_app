import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/presentation/utils/map_failure_to_message.dart';
import 'package:vgv_coffee_app/presentation/widgets/download_image_button.dart';
import 'package:vgv_coffee_app/presentation/widgets/reload_image_button.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeCubit, CoffeeState>(
      builder: (context, state) {
        if (state is CoffeeErrorState) {
          return _ImageFailure(failure: state.failure);
        } else if (state is CoffeeLoadedState) {
          return _ImageLoaded(coffee: state.coffee);
        }

        return const _ImageLoading();
      },
    );
  }
}

class _ImageLoaded extends StatelessWidget {
  final Coffee coffee;

  const _ImageLoaded({Key? key, required this.coffee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.network(coffee.url),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: DownloadImageButton(url: coffee.url),
            ),
            const Expanded(
              child: ReloadImageButton(),
            ),
          ],
        ),
      ],
    );
  }
}

class _ImageLoading extends StatelessWidget {
  const _ImageLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ImageFailure extends StatelessWidget {
  final Failure failure;

  const _ImageFailure({required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            failure.mapFailureToMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              context.read<CoffeeCubit>().reloadCoffee();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
