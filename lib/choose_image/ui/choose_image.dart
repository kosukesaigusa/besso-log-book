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
              ? const Icon(Icons.photo)
              : Image.memory(chosenImageData),
        ),
        const Gap(32),
        ElevatedButton(
          onPressed: () => ref.read(chooseImageControllerProvider).pickImage(),
          child: const Text('画像を選択する'),
        ),
      ],
    );
  }
}
