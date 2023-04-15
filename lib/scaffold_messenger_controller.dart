import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './string.dart';

final scaffoldMessengerKeyProvider =
    Provider((_) => GlobalKey<ScaffoldMessengerState>());

final scaffoldMessengerControllerProvider = Provider.autoDispose(
  (ref) => ScaffoldMessengerController(
    scaffoldMessengerKey: ref.watch(scaffoldMessengerKeyProvider),
  ),
);

/// ツリー上部の [ScaffoldMessenger] 上でスナックバーやダイアログの表示を操作する。
class ScaffoldMessengerController {
  ScaffoldMessengerController({
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  }) : _scaffoldMessengerKey = scaffoldMessengerKey;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  BuildContext get _currentContext => _scaffoldMessengerKey.currentContext!;

  ScaffoldMessengerState get _currentState =>
      _scaffoldMessengerKey.currentState!;

  static const _defaultSnackBarBehavior = SnackBarBehavior.floating;

  static const _defaultSnackBarDuration = Duration(seconds: 3);

  static const _generalExceptionMessage = 'エラーが発生しました。';

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

  /// [showSnackBar] でスナックバーを表示する。
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message, {
    bool removeCurrentSnackBar = true,
    Duration duration = _defaultSnackBarDuration,
  }) {
    if (removeCurrentSnackBar) {
      _currentState.removeCurrentSnackBar();
    }
    return _currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: _defaultSnackBarBehavior,
        duration: duration,
      ),
    );
  }

  /// 一般的な [Exception] 起点でスナックバーを表示する。
  /// Dart の [Exception] 型の場合は toString() の冒頭を取り除いて
  /// 差し支えのないメッセージに置換しておく。
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSnackBarByException(Exception e) {
    final message =
        e.toString().replaceAll('Exception: ', '').replaceAll('Exception', '');
    return showSnackBar(message.ifIsEmpty(_generalExceptionMessage));
  }

  /// [FirebaseException] 起点でスナックバーを表示する。
  ScaffoldFeatureController<SnackBar,
      SnackBarClosedReason> showSnackBarByFirebaseException(
    FirebaseException e,
  ) =>
      showSnackBar('[${e.code}]: ${e.message ?? 'FirebaseException が発生しました。'}');
}
