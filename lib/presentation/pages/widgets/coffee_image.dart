import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/entities/coffee.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/download_image_button.dart';

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
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(coffee.url),
        ),
        DownloadImageButton(
          url: coffee.url,
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

class _ImageLoading extends StatelessWidget {
  const _ImageLoading();

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}

class _ImageFailure extends StatelessWidget {
  final Failure failure;

  const _ImageFailure({required this.failure});

  @override
  Widget build(BuildContext context) {
    return Text('failure');
  }
}
