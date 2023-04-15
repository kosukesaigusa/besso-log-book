import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'visitor_log_controller.dart';

/// 画像を選択したり、名前やひとことを入力して、訪問記録を作成するための
///  [AlertDialog]。
class VisitorLogCreateDialog extends ConsumerWidget {
  const VisitorLogCreateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedImageData = ref.watch(pickedImageDataStateProvider);
    return AlertDialog(
      title: const Text('訪問記録の作成'),
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pickedImageData == null) ...[
                const Icon(Icons.photo_outlined, size: 64),
                const Gap(32),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(visitorLogControllerProvider).pickImage(),
                  child: const Text('画像を選択する'),
                ),
                const Gap(16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.grey),
                  ),
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
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('投稿する'),
                ),
                const Gap(16),
                TextButton(
                  onPressed: () =>
                      ref.read(visitorLogControllerProvider).resetPickedImage(),
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
