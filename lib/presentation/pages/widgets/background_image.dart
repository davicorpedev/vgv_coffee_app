import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;

    return Image.asset(
      'assets/background.jpeg',
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.fill,
      color: color.withOpacity(0.8),
      colorBlendMode: BlendMode.hardLight,
    );
  }
}
