import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'choose_image_controller.dart';

/// 端末から画像を選択するかカメラを起動して写真を撮るかして、
/// 選択・撮影した画像を表示するウィジェット。
class ChooseImage extends ConsumerWidget {
  const ChooseImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenImageData = ref.watch(chosenImageDataStateProvider);
    final chooseImageController = ref.watch(chooseImageControllerProvider);
    return Column(
      children: [
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: chosenImageData == null
              ? FutureBuilder<void>(
                  future: chooseImageController.initializeCameraController,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // TODO: 一度写真を撮影した後に、その画像データをメモリから
                      // 破棄したとき、CameraPreview が固定画像になってしまうので
                      // その原因を調査して対応する。
                      return CameraPreview(ref.watch(cameraControllerProvider));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Image.memory(chosenImageData),
        ),
        const Gap(32),
        ElevatedButton(
          onPressed: () => ref
              .read(chooseImageControllerProvider)
              .chooseImage(ImageSource.gallery),
          child: const Text('端末から画像を選択する'),
        ),
        const Gap(16),
        ElevatedButton(
          onPressed: () => chosenImageData == null
              ? ref
                  .read(chooseImageControllerProvider)
                  .chooseImage(ImageSource.camera)
              : ref.read(chooseImageControllerProvider).resetChosenImage(),
          child: Text(chosenImageData == null ? '写真を撮る' : '選択し直す'),
        ),
      ],
    );
  }
}
