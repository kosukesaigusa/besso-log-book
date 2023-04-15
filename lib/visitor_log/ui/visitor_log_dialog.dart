import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../loading/ui/overlay_loading.dart';
import 'visitor_log_controller.dart';

part 'visitor_log_dialog.freezed.dart';

@freezed
class VisitorLogDialogType with _$VisitorLogDialogType {
  const factory VisitorLogDialogType.read({required VisitorLog visitorLog}) =
      Read;
  const factory VisitorLogDialogType.create() = Create;
}

/// 訪問記録詳細を表示する、または、画像を選択したり、名前やひとことを入力して、
/// 訪問記録を作成するための [AlertDialog]。
class VisitorLogDialog extends ConsumerWidget {
  const VisitorLogDialog({super.key, required this.visitorLogDialogType});

  /// 訪問記録詳細の表示と作成とのどちらの目的でこのウィジェットを使用するか。
  final VisitorLogDialogType visitorLogDialogType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          title: const Text('投稿'),
          content: SizedBox(
            width: min(MediaQuery.of(context).size.width, 480),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...visitorLogDialogType.when(
                    read: (visitorLog) => [
                      SizedBox(
                        width: 96,
                        child: Image.network(visitorLog.imageUrl),
                      ),
                      const Gap(16),
                      _VisitorNameTextField(
                        enabled: false,
                        text: visitorLog.visitorName,
                      ),
                      const Gap(16),
                      _DescriptionTextField(
                        enabled: false,
                        text: visitorLog.description,
                      ),
                    ],
                    create: () {
                      final pickedImageData =
                          ref.watch(pickedImageDataStateProvider);
                      return [
                        if (pickedImageData == null) ...[
                          const Icon(Icons.photo_outlined, size: 64),
                          const Gap(32),
                          ElevatedButton(
                            onPressed: () => ref
                                .read(visitorLogControllerProvider)
                                .pickImage(),
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
                            width: 96,
                            child: Image.memory(pickedImageData),
                          ),
                          const Gap(4),
                          TextButton(
                            onPressed: () => ref
                                .read(visitorLogControllerProvider)
                                .resetPickedImage(),
                            child: const Text(
                              '画像を選び直す',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          const Gap(16),
                          const _VisitorNameTextField(enabled: true),
                          const Gap(16),
                          const _DescriptionTextField(enabled: true),
                          const Gap(16),
                          ElevatedButton(
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              await ref
                                  .read(visitorLogControllerProvider)
                                  .createVisitorLog(
                                    visitorName: ref
                                        .read(visitorNameTextEditingController)
                                        .text,
                                    description: ref
                                        .read(descriptionTextEditingController)
                                        .text,
                                    imageData: pickedImageData,
                                  );
                              navigator.pop();
                            },
                            child: const Text('投稿'),
                          ),
                        ],
                      ];
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (ref.watch(showOverlayLoadingOnVisitorLogCreateDialogStateProvider))
          const OverlayLoading(),
      ],
    );
  }
}

class _VisitorNameTextField extends StatefulHookConsumerWidget {
  const _VisitorNameTextField({
    required this.enabled,
    this.text,
  }) : assert(
          (enabled || text != null) || (!enabled && text == null),
          'enabledがfalseの場合のみtextを入れてください',
        );

  final bool enabled;
  final String? text;

  @override
  ConsumerState<_VisitorNameTextField> createState() =>
      _VisitorNameTextFieldState();
}

class _VisitorNameTextFieldState extends ConsumerState<_VisitorNameTextField> {
  @override
  void initState() {
    if (widget.text != null) {
      ref.read(visitorNameTextEditingController).text = widget.text!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled,
      controller: ref.watch(visitorNameTextEditingController),
      decoration: InputDecoration(
        labelText: '訪問者の名前',
        fillColor: Colors.grey[200],
        border: InputBorder.none,
        filled: true,
      ),
    );
  }
}

class _DescriptionTextField extends StatefulHookConsumerWidget {
  const _DescriptionTextField({
    required this.enabled,
    this.text,
  }) : assert(
          (enabled || text != null) || (!enabled && text == null),
          'enabledがfalseの場合のみtextを入れてください',
        );

  final bool enabled;
  final String? text;

  @override
  ConsumerState<_DescriptionTextField> createState() =>
      _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends ConsumerState<_DescriptionTextField> {
  @override
  void initState() {
    if (widget.text != null) {
      ref.read(descriptionTextEditingController).text = widget.text!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled,
      controller: ref.watch(descriptionTextEditingController),
      keyboardType: TextInputType.multiline,
      minLines: 2,
      maxLines: null,
      decoration: InputDecoration(
        labelText: '思い出やひとこと',
        fillColor: Colors.grey[200],
        border: InputBorder.none,
        filled: true,
      ),
    );
  }
}
