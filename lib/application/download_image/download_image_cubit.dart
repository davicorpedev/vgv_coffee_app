import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';

part 'download_image_state.dart';

class DownloadImageCubit extends Cubit<DownloadImageState> {
  final ImageRepository _repository;

  DownloadImageCubit({
    required ImageRepository repository,
  })  : _repository = repository,
        super(DownloadImageInitialState());

  Future<void> downloadImage(String url) async {
    emit(DownloadImageLoadingState());

    final result = await _repository.downloadImage(url);

    result.when(
      success: (success) {
        emit(DownloadImageSuccessState());
      },
      error: (failure) {
        emit(DownloadImageErrorState(failure: failure));
      },
    );
  }
}
