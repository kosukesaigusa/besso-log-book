import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../router/router.gr.dart';

@RoutePage()
class VisitorLogsPage extends StatelessWidget {
  const VisitorLogsPage({super.key});

  static const path = '/visitorLogs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.router
                  .push(VisitorLogDetailRoute(visitorLogId: 'abc')),
              child: const Text('Go to visitorLogs/abc'),
            ),
          ],
        ),
      ),
    );
  }
}
