import 'package:image_downloader/image_downloader.dart';

class VGVImageDownloader {
  Future<String?> download(String url) async {
    final imageId = await ImageDownloader.downloadImage(url);

    return imageId;
  }
}
