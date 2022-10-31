import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/download_image/download_image_cubit.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';
import 'package:vgv_coffee_app/presentation/core/failure_to_message.dart';

class DownloadImageButton extends StatelessWidget {
  final String url;

  const DownloadImageButton({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadImageCubit(
        repository: RepositoryProvider.of<ImageRepository>(context),
      ),
      child: BlocConsumer<DownloadImageCubit, DownloadImageState>(
        listener: (context, state) {
          if (state is DownloadImageSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('The image has beeen downloaded'),
              ),
            );
          } else if (state is DownloadImageErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.mapFailureToMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DownloadImageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return OutlinedButton(
            child: const Text(
              'Download Image',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              context.read<DownloadImageCubit>().downloadImage(url);
            },
          );
        },
      ),
    );
  }
}
