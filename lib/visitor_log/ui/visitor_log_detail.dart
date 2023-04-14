import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class VisitorLogDetailPage extends ConsumerWidget {
  const VisitorLogDetailPage({
    @PathParam('visitorLogId') required this.visitorLogId,
    super.key,
  });

  final String visitorLogId;

  static const path = '/visitorLogs/:visitorLogId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('訪問記録')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('訪問記録 ID: $visitorLogId'),
          ],
        ),
      ),
    );
  }
}
