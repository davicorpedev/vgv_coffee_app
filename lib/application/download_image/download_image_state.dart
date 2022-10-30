part of 'download_image_cubit.dart';

abstract class DownloadImageState extends Equatable {
  const DownloadImageState();

  @override
  List<Object> get props => [];
}

class DownloadImageInitialState extends DownloadImageState {}

class DownloadImageLoadingState extends DownloadImageState {}

class DownloadImageSuccessState extends DownloadImageState {}

class DownloadImageErrorState extends DownloadImageState {
  final Failure failure;

  const DownloadImageErrorState({required this.failure});

  @override
  List<Object> get props => [failure];
}
