import 'package:image_downloader/image_downloader.dart';

typedef ImageDownloaderCallback = Future<String?> Function(String url);

abstract class VGVImageDownloader {
  Future<String?> download(String url);
}

class VGVImageDownloaderImpl implements VGVImageDownloader {
  final ImageDownloaderCallback _downloader;

  ImageDownloaderCallback get downloader => _downloader;

  VGVImageDownloaderImpl({
    ImageDownloaderCallback? overrideImageDownloader,
  }) : _downloader = overrideImageDownloader ?? ImageDownloader.downloadImage;

  @override
  Future<String?> download(String url) async {
    final imageId = await _downloader(url);

    return imageId;
  }
}
