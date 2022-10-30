import 'package:flutter/services.dart';
import 'package:vgv_coffee_app/domain/core/entities/result.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/domain/core/utils/vgv_image_downloader.dart';

abstract class ImageRepository {
  Future<Result<String>> downloadImage(String url);
}

class ImageRepositoryImpl extends ImageRepository {
  final VGVImageDownloader _imageDownloader;

  ImageRepositoryImpl({
    required VGVImageDownloader imageDownloader,
  }) : _imageDownloader = imageDownloader;

  @override
  Future<Result<String>> downloadImage(String url) async {
    try {
      final imageId = await _imageDownloader.download(url);

      if (imageId == null) {
        return Result.error(ImagePermissionsFailure());
      } else {
        return Result.success(imageId);
      }
    } on PlatformException {
      return Result.error(InvalidImageFailure());
    }
  }
}
