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
    final chosenImageUintList = ref.watch(chosenImageData);
    final controller = ref.watch(chooseImageController);
    return Column(
      children: [
        Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: chosenImageUintList == null
              ? FutureBuilder<void>(
                  future: controller.initializeCameraController,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(ref.watch(cameraController));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Image.memory(chosenImageUintList),
        ),
        const Gap(32),
        ElevatedButton(
          onPressed: () =>
              ref.read(chooseImageController).chooseImage(ImageSource.gallery),
          child: const Text('端末から画像を選択する'),
        ),
        const Gap(16),
        ElevatedButton(
          onPressed: () => chosenImageUintList == null
              ? ref.read(chooseImageController).chooseImage(ImageSource.camera)
              : ref.read(chooseImageController).resetChosenImage(),
          child: const Text('カメラを起動して写真を撮る'),
        ),
      ],
    );
  }
}
