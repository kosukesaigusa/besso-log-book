import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'pick_image_controller.dart';

/// 端末から画像を選択するかカメラを起動して写真を撮るかして、
/// 選択・撮影した画像を表示するウィジェット。
class PickImage extends ConsumerWidget {
  const PickImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedImageData = ref.watch(pickedImageDataStateProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pickedImageData == null) ...[
            const Icon(Icons.photo_outlined, size: 64),
            const Gap(32),
            ElevatedButton(
              onPressed: () =>
                  ref.read(pickImageControllerProvider).pickImage(),
              child: const Text('画像を選択する'),
            ),
            const Gap(16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('キャンセル'),
            ),
          ] else ...[
            Image.memory(pickedImageData),
            const Gap(16),
            const TextField(
              decoration: InputDecoration(labelText: '訪問者の名前'),
            ),
            const Gap(16),
            const TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(labelText: '思い出やひとこと'),
            ),
            const Gap(16),
            TextButton(
              onPressed: () =>
                  ref.read(pickImageControllerProvider).resetPickedImage(),
              child: const Text('キャンセル'),
            ),
          ],
        ],
      ),
    );
  }
}
