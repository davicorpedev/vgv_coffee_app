import 'package:flutter/services.dart';
import 'package:vgv_coffee_app/domain/entities/result.dart';
import 'package:vgv_coffee_app/domain/error/failures.dart';
import 'package:vgv_coffee_app/domain/utils/network_info.dart';
import 'package:vgv_coffee_app/domain/utils/vgv_image_downloader.dart';

abstract class ImageRepository {
  Future<Result<String>> downloadImage(String url);
}

class ImageRepositoryImpl implements ImageRepository {
  final VGVImageDownloader _imageDownloader;
  final NetworkInfo _networkInfo;

  ImageRepositoryImpl({
    required VGVImageDownloader imageDownloader,
    required NetworkInfo networkInfo,
  })  : _imageDownloader = imageDownloader,
        _networkInfo = networkInfo;

  @override
  Future<Result<String>> downloadImage(String url) async {
    if (await _networkInfo.isConnected) {
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
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
