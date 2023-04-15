import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mainNavigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

final mainNavigatorControllerProvider =
    Provider.autoDispose<NavigatorController>(
  (ref) =>
      NavigatorController(navigatorKey: ref.watch(mainNavigatorKeyProvider)),
);

/// navigatorKey を用いてダイアログやモーダルボトムシートを表示するコントローラ。
class NavigatorController {
  NavigatorController({
    required GlobalKey<NavigatorState> navigatorKey,
  }) : _navigatorKey = navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey;

  BuildContext get _currentContext => _navigatorKey.currentContext!;

  /// [showDialog] で指定したビルダー関数を返す。
  Future<T?> showDialogByBuilder<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: _currentContext,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// [showModalBottomSheet] で指定したビルダー関数を返す。
  Future<T?> showModalBottomSheetByBuilder<T>({
    required Widget Function(BuildContext) builder,
  }) async {
    return showModalBottomSheet<T>(
      context: _currentContext,
      builder: builder,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
    );
  }
}
