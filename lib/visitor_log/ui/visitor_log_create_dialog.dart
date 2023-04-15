import 'dart:math';

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
      insetPadding: const EdgeInsets.all(16),
      title: const Text(
        '投稿',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: min(MediaQuery.of(context).size.width, 480),
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
                SizedBox(
                  width: 80,
                  child: Image.memory(pickedImageData),
                ),
                const Gap(4),
                TextButton(
                  onPressed: () =>
                      ref.read(visitorLogControllerProvider).resetPickedImage(),
                  child: const Text(
                    '画像を選び直す',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const Gap(16),
                TextField(
                  controller: ref.watch(visitorNameTextEditingController),
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: '訪問者の名前',
                    labelStyle: TextStyle(fontSize: 10),
                  ),
                ),
                const Gap(16),
                TextField(
                  controller: ref.watch(descriptionTextEditingController),
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: '思い出やひとこと',
                    labelStyle: TextStyle(fontSize: 10),
                  ),
                ),
                const Gap(16),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await ref
                        .read(visitorLogControllerProvider)
                        .createVisitorLog(
                          visitorName:
                              ref.read(visitorNameTextEditingController).text,
                          description:
                              ref.read(descriptionTextEditingController).text,
                          imageData: pickedImageData,
                        );
                    navigator.pop();
                  },
                  child: const Text('投稿する'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
