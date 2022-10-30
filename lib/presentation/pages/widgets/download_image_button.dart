import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_coffee_app/application/download_image/download_image_cubit.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';

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
                content: Text('Image downloaded'),
              ),
            );
          } else if (state is DownloadImageErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error while downloading the image'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DownloadImageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Click here to download this image',
            onPressed: () {
              context.read<DownloadImageCubit>().downloadImage(url);
            },
          );
        },
      ),
    );
  }
}
