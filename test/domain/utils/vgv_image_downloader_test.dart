import 'package:flutter_test/flutter_test.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:vgv_coffee_app/domain/utils/vgv_image_downloader.dart';

void main() {
  group(
    'download',
    () {
      const tUrl = 'test.png';

      test(
        'should build downloader as ImageDownloader.downloadImage if we do not pass any parameter to the constructor',
        () async {
          final imageDownloader = VGVImageDownloaderImpl();

          expect(
            imageDownloader.downloader,
            ImageDownloader.downloadImage,
          );
        },
      );

      test(
        'should return String if the downloader returns String',
        () async {
          const tResult = 'test';

          final imageDownloader = VGVImageDownloaderImpl(
            overrideImageDownloader: (url) {
              return Future.value(tResult);
            },
          );

          final result = await imageDownloader.download(tUrl);

          expect(result, tResult);
        },
      );

      test(
        'should return null if the downloader returns null',
        () async {
          const tResult = null;

          final imageDownloader = VGVImageDownloaderImpl(
            overrideImageDownloader: (url) {
              return Future.value(tResult);
            },
          );

          final result = await imageDownloader.download(tUrl);

          expect(result, tResult);
        },
      );
    },
  );
}
