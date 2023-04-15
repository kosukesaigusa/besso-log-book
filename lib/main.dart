import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'choose_image/ui/choose_image_controller.dart';
import 'firebase_options.dart';
import 'loading/loading.dart';
import 'loading/ui/overlay_loading.dart';
import 'router/router.dart';
import 'scaffold_messenger_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final availableCameraDescription = await _getAvailableCameraDescription();
  runApp(
    ProviderScope(
      overrides: [
        cameraDescriptionProvider.overrideWithValue(availableCameraDescription),
      ],
      child: const App(),
    ),
  );
}

/// 使用可能なカメラを取得する。
/// 取得できない場合も例外は起こさずに null を返すようにする。
Future<CameraDescription?> _getAvailableCameraDescription() async {
  try {
    final cameras = await availableCameras();
    return cameras.isEmpty ? null : cameras.first;
  } on CameraException {
    return null;
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    return null;
  }
}

final _appRouterProvider = Provider.autoDispose<AppRouter>((_) => AppRouter());

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter 別荘 LogBook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
      routerConfig: ref.watch(_appRouterProvider).config(),
      builder: (context, child) {
        final isLoading = ref.watch(showOverlayLoadingStateProvider);
        return Material(
          child: Stack(
            children: [
              child!,
              if (isLoading) const OverlayLoading(),
            ],
          ),
        );
      },
    );
  }
}
