import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../firestore/firestore_repository/visitor_log.dart';
import '../../scaffold_messenger_controller.dart';
import 'visitor_log_create_dialog.dart';

final visitorLogsStreamProvider =
    StreamProvider.autoDispose<List<VisitorLog>>((ref) {
  final repository = ref.watch(visitorLogRepositoryProvider);
  return repository.subscribeVisitorLogs();
});

@RoutePage()
class VisitorLogsPage extends ConsumerWidget {
  const VisitorLogsPage({super.key});

  static const path = '/visitorLogs';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('width: ${MediaQuery.of(context).size.width},'
        ' height: ${MediaQuery.of(context).size.height}');
    return ref.watch(visitorLogsStreamProvider).when(
          data: (visitorLogs) {
            // todo change color
            return Scaffold(
              appBar: AppBar(
                title: const Text('LogBook'),
                backgroundColor: Colors.black,
                elevation: 0,
              ),
              body: Center(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                      color: Colors.brown,
                      border: Border(
                        right: BorderSide(
                          color: Colors.black,
                          width: 20,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 20,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 20,
                        ),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                        itemCount: visitorLogs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          //todo webとmobileの分岐点（出来ればここだけで抑えたい）
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // todo commented out
                                    //   context.router.push<void>(
                                    //   VisitorLogDetailRoute(visitorLogId: 'abc'),
                                    // );
                                  },
                                  child: DecoratedBox(
                                    decoration: const BoxDecoration(
                                        // todo commented out
                                        // color: Colors.grey,
                                        ),
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      // todo random color
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Expanded(
                                                    child: Image.asset(
                                                      'assets/images/example_photo.jpeg',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                ],
                                              ),
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
                        }),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => ref
                    .read(scaffoldMessengerControllerProvider)
                    .showDialogByBuilder<void>(
                      barrierDismissible: false,
                      builder: (context) => const VisitorLogCreateDialog(),
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
