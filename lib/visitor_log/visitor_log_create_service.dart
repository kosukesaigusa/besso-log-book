import 'package:hooks_riverpod/hooks_riverpod.dart';

final visitorLogCreateService =
    Provider.autoDispose((_) => VisitorLogCreateService());

/// [VisitorLog] を作成するためのサービスクラス（モデル）。
class VisitorLogCreateService {
  /// [VisitorLog] を作成する。
  Future<void> create() async {
    // TODO: 仮実装。
    throw UnimplementedError();
  }
}
