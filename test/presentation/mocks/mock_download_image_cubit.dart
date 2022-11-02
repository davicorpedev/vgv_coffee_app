import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vgv_coffee_app/application/download_image/download_image_cubit.dart';

class MockDownloadImageCubit extends MockCubit<DownloadImageState>
    implements DownloadImageCubit {}

class DownloadImageStateFake extends Fake implements DownloadImageState {}
