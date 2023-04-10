import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OverlayLoading extends ConsumerWidget {
  const OverlayLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: ColoredBox(
        color: Colors.black26,
        child: SizedBox.expand(
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
