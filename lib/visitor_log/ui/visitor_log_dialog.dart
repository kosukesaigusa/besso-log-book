import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../firestore/union_timestamp.dart';
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
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('投稿'),
              ...visitorLogDialogType.when(
                read: (visitorLog) => [
                  const Gap(16),
                  Text(
                    _toDateString(visitorLog.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                create: () => const [],
              ),
            ],
          ),
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => _ExpandedImage(
                                  imageWidget:
                                      NetworkImage(visitorLog.imageUrl),
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Image.network(visitorLog.imageUrl),
                        ),
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
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: IconButton(
                          onPressed: () async {
                            await showDialog<void>(
                              context: context,
                              builder: (_) {
                                return _DeleteConfirmDialog(
                                  onConfirmed: () async {
                                    final navigator = Navigator.of(context);
                                    final isSucceeded = await ref
                                        .read(visitorLogControllerProvider)
                                        .delete(visitorLog: visitorLog);
                                    if (isSucceeded) {
                                      navigator.pop();
                                    }
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
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
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) => _ExpandedImage(
                                        imageWidget:
                                            MemoryImage(pickedImageData),
                                      ),
                                      fullscreenDialog: true,
                                    ),
                                  );
                                },
                                child: Image.memory(pickedImageData)),
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

  String _toDateString(UnionTimestamp createdAt) {
    final dateTime = createdAt.dateTime;
    if (dateTime == null) {
      return '';
    }
    final year = createdAt.dateTime!.year;
    final month = createdAt.dateTime!.month;
    final day = createdAt.dateTime!.day;
    return '$year年$month月$day日';
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

class _DeleteConfirmDialog extends StatelessWidget {
  const _DeleteConfirmDialog({
    required this.onConfirmed,
  });

  final VoidCallback onConfirmed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: min(MediaQuery.of(context).size.width, 440),
        height: 154,
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 60,
              child: Center(
                child: Text(
                  '投稿を削除しますか？',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        'キャンセル',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 48,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text(
                        '削除する',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirmed();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ExpandedImage extends StatefulWidget {
  const _ExpandedImage({
    required this.imageWidget,
  });

  final ImageProvider imageWidget;

  @override
  State<_ExpandedImage> createState() => _ExpandedImageState();
}

class _ExpandedImageState extends State<_ExpandedImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: widget.imageWidget,
          ),
        ),
      ),
    );
  }
}
