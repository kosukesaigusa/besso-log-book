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
    return Column(
      children: [
        if (chosenImageUintList != null) ...[
          const Text('選択された画像'),
          Image.memory(chosenImageUintList),
          const Divider(),
        ],
        ElevatedButton(
          onPressed: () =>
              ref.read(chooseImageController).chooseImage(ImageSource.gallery),
          child: const Text('端末から画像を選択する'),
        ),
        const Gap(16),
        ElevatedButton(
          onPressed: () =>
              ref.read(chooseImageController).chooseImage(ImageSource.camera),
          child: const Text('カメラを起動して写真を撮る'),
        ),
      ],
    );
  }
}
