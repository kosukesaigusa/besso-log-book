import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VisitorLogCreatePage extends StatelessWidget {
  const VisitorLogCreatePage({super.key});

  static const path = '/visitorLogs/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Create visitorLog.'),
            ),
          ],
        ),
      ),
    );
  }
}
