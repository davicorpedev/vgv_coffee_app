import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vgv_coffee_app/application/download_image/download_image_cubit.dart';
import 'package:vgv_coffee_app/domain/core/error/failures.dart';
import 'package:vgv_coffee_app/presentation/core/map_failure_to_message.dart';
import 'package:vgv_coffee_app/presentation/pages/widgets/download_image_button.dart';

import '../mocks/mock_download_image_cubit.dart';
import '../pump_app.dart';

void main() {
  late MockDownloadImageCubit imageCubit;

  setUpAll(() {
    registerFallbackValue(DownloadImageStateFake());
  });

  setUp(
    () {
      imageCubit = MockDownloadImageCubit();
    },
  );

  const tUrl = 'test.test.jpg';

  testWidgets(
    'Should find a Download Image Label if the state is DownloadImageSuccessState',
    (tester) async {
      when(() => imageCubit.state).thenReturn(DownloadImageSuccessState());

      await tester.pumpApp(
        BlocProvider<DownloadImageCubit>.value(
          value: imageCubit,
          child: const Scaffold(
            body: DownloadImageButtonBody(
              url: tUrl,
            ),
          ),
        ),
      );

      expect(find.text('Download Image'), findsOneWidget);
    },
  );

  testWidgets(
    'Should find a CircularProgressIndicator widget if the state is DownloadImageLoadingState',
    (tester) async {
      when(() => imageCubit.state).thenReturn(DownloadImageLoadingState());

      await tester.pumpApp(
        BlocProvider<DownloadImageCubit>.value(
          value: imageCubit,
          child: const Scaffold(
            body: DownloadImageButtonBody(
              url: tUrl,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Should call downloadImage on tapping on the Download Image Button',
    (tester) async {
      when(() => imageCubit.state).thenReturn(DownloadImageInitialState());
      when((() => imageCubit.downloadImage(any()))).thenAnswer(
        (_) async => () {},
      );

      await tester.pumpApp(
        BlocProvider<DownloadImageCubit>.value(
          value: imageCubit,
          child: const Scaffold(
            body: DownloadImageButtonBody(
              url: tUrl,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Download Image'));

      verify(() => imageCubit.downloadImage(tUrl)).called(1);
    },
  );

  testWidgets(
    'Should find a SnackBar with the Enjoy your coffee Label if the state is DownloadImageSuccessState',
    (tester) async {
      when(() => imageCubit.state).thenReturn(DownloadImageInitialState());
      when((() => imageCubit.downloadImage(any()))).thenAnswer(
        (_) async => () {},
      );
      whenListen(
        imageCubit,
        Stream.fromIterable(
          [DownloadImageSuccessState()],
        ),
      );

      await tester.pumpApp(
        BlocProvider<DownloadImageCubit>.value(
          value: imageCubit,
          child: const Scaffold(
            body: DownloadImageButtonBody(
              url: tUrl,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Download Image'));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Enjoy your coffee ☕'), findsOneWidget);
    },
  );

  testWidgets(
    'Should find a SnackBar with a Failure message if the state is DownloadImageErrorState',
    (tester) async {
      final tFailure = ServerFailure();

      when(() => imageCubit.state).thenReturn(
        DownloadImageInitialState(),
      );
      when((() => imageCubit.downloadImage(any()))).thenAnswer(
        (_) async => () {},
      );
      whenListen(
        imageCubit,
        Stream.fromIterable(
          [
            DownloadImageErrorState(failure: tFailure),
          ],
        ),
      );

      await tester.pumpApp(
        BlocProvider<DownloadImageCubit>.value(
          value: imageCubit,
          child: const Scaffold(
            body: DownloadImageButtonBody(
              url: tUrl,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Download Image'));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text(tFailure.mapFailureToMessage), findsOneWidget);
    },
  );
}
