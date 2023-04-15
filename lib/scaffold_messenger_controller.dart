import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './string.dart';

final mainScaffoldMessengerKeyProvider =
    Provider((_) => GlobalKey<ScaffoldMessengerState>());

final mainScaffoldMessengerControllerProvider =
    Provider.autoDispose<ScaffoldMessengerController>(
  (ref) => ScaffoldMessengerController(
    scaffoldMessengerKey: ref.watch(mainScaffoldMessengerKeyProvider),
  ),
);

/// ツリー上部の [ScaffoldMessenger] 上でスナックバーやダイアログの表示を操作する。
class ScaffoldMessengerController {
  ScaffoldMessengerController({
    required GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey,
  }) : _scaffoldMessengerKey = scaffoldMessengerKey;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  ScaffoldMessengerState get _currentState =>
      _scaffoldMessengerKey.currentState!;

  static const _defaultSnackBarBehavior = SnackBarBehavior.floating;

  static const _defaultSnackBarDuration = Duration(seconds: 3);

  static const _generalExceptionMessage = 'エラーが発生しました。';

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
