import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../pick_image/ui/pick_image.dart';

@RoutePage()
class VisitorLogCreatePage extends StatelessWidget {
  const VisitorLogCreatePage({super.key});

  static const path = '/visitorLog/create';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('訪問記録作成')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            PickImage(),
          ],
        ),
      ),
    );
  }
}
