import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../router/router.gr.dart';

@RoutePage()
class VisitorLogsPage extends ConsumerWidget {
  const VisitorLogsPage({super.key});

  static const path = '/visitorLogs';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onPressed: () => context.router.push<void>(
          const VisitorLogCreateRoute(),
        ),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
