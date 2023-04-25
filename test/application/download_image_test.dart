import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/download_image/download_image_cubit.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';

class MockImageRepository extends Mock implements ImageRepository {}

void main() {
  late MockImageRepository repository;

  setUp(() {
    repository = MockImageRepository();
  });

  blocTest(
    'Initial state should be DownloadImageInitialState',
    build: () => DownloadImageCubit(repository: repository),
    verify: (cubit) {
      expect(cubit.state, DownloadImageInitialState());
    },
  );

  group(
    'downloadImage',
    () {
      const tImageId = 'testId';
      const tUrl = 'test.test.jpg';

      blocTest(
        'should call downloadImage from repository',
        build: () => DownloadImageCubit(repository: repository),
        setUp: () {
          when(() => repository.downloadImage(any())).thenAnswer(
            (_) async => Result.success(tImageId),
          );
        },
        act: (bloc) => bloc.downloadImage(tUrl),
        verify: (cubit) {
          verify(() => repository.downloadImage(tUrl)).called(1);
        },
      );

      blocTest(
        'should emit [DownloadImageLoadingState, DownloadImageSuccessState] if the repository returns success',
        build: () => DownloadImageCubit(repository: repository),
        setUp: () {
          when(() => repository.downloadImage(any())).thenAnswer(
            (_) async => Result.success(tImageId),
          );
        },
        act: (bloc) => bloc.downloadImage(tUrl),
        expect: () {
          return [
            DownloadImageLoadingState(),
            DownloadImageSuccessState(),
          ];
        },
      );

      blocTest(
        'should emit [DownloadImageLoadingState, DownloadImageErrorState] if the repository returns error',
        build: () => DownloadImageCubit(repository: repository),
        setUp: () {
          when(() => repository.downloadImage(any())).thenAnswer(
            (_) async => Result.error(ImagePermissionsFailure()),
          );
        },
        act: (bloc) => bloc.downloadImage(tUrl),
        expect: () {
          return [
            DownloadImageLoadingState(),
            DownloadImageErrorState(failure: ImagePermissionsFailure()),
          ];
        },
      );
    },
  );
}
