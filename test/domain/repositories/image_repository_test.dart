import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/domain/core/entities/result.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/core/utils/vgv_image_downloader.dart';
import 'package:vgv_coffee_app/domain/repositories/image_repository.dart';

class MockVGVmageDownloader extends Mock implements VGVImageDownloader {}

void main() {
  late MockVGVmageDownloader imageDownloader;
  late ImageRepository repository;

  setUp(() {
    imageDownloader = MockVGVmageDownloader();
    repository = ImageRepositoryImpl(imageDownloader: imageDownloader);
  });

  group(
    'downloadImage',
    () {
      const tImageId = 'testId';
      const tUrl = 'test.test.jpg';

      test(
        'should call download on ImageDownloader',
        () async {
          when(() => imageDownloader.download(any())).thenAnswer(
            (_) async => tImageId,
          );

          await repository.downloadImage(tUrl);

          verify(() => imageDownloader.download(tUrl)).called(1);
        },
      );

      test(
        'should return an imageId if the image has been downloaded',
        () async {
          when(() => imageDownloader.download(any())).thenAnswer(
            (_) async => tImageId,
          );

          final result = await repository.downloadImage(tUrl);

          expect(
            result,
            Result<String>.success(tImageId),
          );
        },
      );

      test(
        'should return ImagePermissionsFailure if the device has no permissions',
        () async {
          when(() => imageDownloader.download(any())).thenAnswer(
            (_) async => null,
          );

          final result = await repository.downloadImage(tUrl);

          expect(
            result,
            Result<String>.error(ImagePermissionsFailure()),
          );
        },
      );

      test(
        'should return InvalidImageFailure if there has been an error',
        () async {
          when(() => imageDownloader.download(any())).thenThrow(
            PlatformException(code: '1'),
          );

          final result = await repository.downloadImage(tUrl);

          expect(
            result,
            Result<String>.error(InvalidImageFailure()),
          );
        },
      );
    },
  );
}
