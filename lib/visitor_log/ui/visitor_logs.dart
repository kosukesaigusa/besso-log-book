import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../firestore/firestore_repository/visitor_log.dart';
import '../../scaffold_messenger_controller.dart';
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
            // todo show dialog
            if (visitorLogId != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog<void>(
                  context: context,
                  builder: (context) {
                    return const VisitorLogDialog(
                      visitorLogDialogType: VisitorLogDialogType.create(),
                    );
                  },
                );
              });
            }

            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Welcome to flutter別荘',
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
                                  // todo show dialog
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
                                                  child: Image.network(
                                                    imageUrl,
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
                backgroundColor: Colors.brown,
                onPressed: () => ref
                    .read(scaffoldMessengerControllerProvider)
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
