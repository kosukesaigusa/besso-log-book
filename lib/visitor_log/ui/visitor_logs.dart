import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../firestore/firestore_repository/visitor_log.dart';
import '../../navigator_controller.dart';
import 'visitor_log_controller.dart';
import 'visitor_log_dialog.dart';

final visitorLogsStreamProvider =
    StreamProvider.autoDispose<List<VisitorLog>>((ref) {
  final repository = ref.watch(visitorLogRepositoryProvider);
  return repository.subscribeVisitorLogs();
});

@RoutePage()
class VisitorLogsPage extends ConsumerWidget {
  const VisitorLogsPage({
    @QueryParam('visitorLogId') this.visitorLogId,
    super.key,
  });

  static const path = '/visitorLogs';
  final String? visitorLogId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('width: ${MediaQuery.of(context).size.width},'
        ' height: ${MediaQuery.of(context).size.height}');
    final width = MediaQuery.of(context).size.width;

    return ref.watch(visitorLogsStreamProvider).when(
          data: (visitorLogs) {
            final isShowDialog =
                ref.read(showVisitorLogDialogStateProvider.notifier);
            if (visitorLogId != null && isShowDialog.state) {
              final log = visitorLogs.firstWhere(
                (visitorLog) => visitorLog.visitorLogId == visitorLogId,
                // 不適切なvisitorLogIdが入力されていた場合
                orElse: () => const VisitorLog(),
              );

              if (log.visitorLogId.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  // 再描画時にはダイアログが表示されないようにする
                  isShowDialog.state = false;
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return VisitorLogDialog(
                        visitorLogDialogType:
                            VisitorLogDialogType.read(visitorLog: log),
                      );
                    },
                  );
                });
              }
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Welcome to Flutter別荘',
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color(0xFFffe6b3),
                elevation: 0,
              ),
              body: Center(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Color(0xFFb37700),
                    border: Border(
                      right: BorderSide(
                        color: Color(0xFFffe6b3),
                        width: 20,
                      ),
                      left: BorderSide(
                        color: Color(0xFFffe6b3),
                        width: 20,
                      ),
                      bottom: BorderSide(
                        color: Color(0xFFffe6b3),
                        width: 20,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      itemCount: visitorLogs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // デバイスの横幅でグリッドの列数を調整
                        crossAxisCount: width < 600
                            ? 2
                            : width <= 1000
                                ? 3
                                : width <= 1400
                                    ? 4
                                    : 5,
                      ),
                      itemBuilder: (context, index) {
                        final log = visitorLogs[index];
                        final imageUrl = log.imageUrl;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) {
                                      return VisitorLogDialog(
                                        visitorLogDialogType:
                                            VisitorLogDialogType.read(
                                          visitorLog: log,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    child: Transform.rotate(
                                      angle: _randomAngle(
                                        min: -0.2,
                                        max: 0.2,
                                      ),
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl: imageUrl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => ref
                    .read(mainNavigatorControllerProvider)
                    .showDialogByBuilder<void>(
                      barrierDismissible: false,
                      builder: (context) => const VisitorLogDialog(
                        visitorLogDialogType: VisitorLogDialogType.create(),
                      ),
                    ),
                child: const Icon(Icons.camera_alt),
              ),
            );
          },
          loading: () => const SizedBox(),
          error: (_, __) => const SizedBox(),
        );
  }

  double _randomAngle({required double min, required double max}) {
    final random = Random();
    return min + (random.nextDouble() * (max - min));
  }
}
