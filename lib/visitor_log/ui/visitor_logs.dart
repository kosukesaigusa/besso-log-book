import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../../firestore/firestore_repository/visitor_log.dart';
import '../../router/router.gr.dart';
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
    // return ref.watch(visitorLogsStreamProvider).when(
    //       data: (visitorLogs) => const SizedBox(),
    //       loading: () => const SizedBox(),
    //       error: (_, __) => const SizedBox(),
    //     );
    return Scaffold(
      appBar: AppBar(title: const Text('訪問記録一覧')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.router
                  .push<void>(VisitorLogDetailRoute(visitorLogId: 'abc')),
              child: const Text('/visitorLogs/:abc ページへ'),
            ),
          ],
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
  }
}
