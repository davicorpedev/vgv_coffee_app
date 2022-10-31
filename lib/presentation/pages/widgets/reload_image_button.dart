import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/coffee/coffee_cubit.dart';

class ReloadImageButton extends StatelessWidget {
  const ReloadImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text(
        'Reload Image',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        context.read<CoffeeCubit>().reloadCoffee();
      },
    );
  }
}
