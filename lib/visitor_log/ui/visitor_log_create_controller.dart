import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../visitor_log_create_service.dart';

final visitorLogCreateController = Provider.autoDispose(
  (ref) =>
      VisitorLogCreateController(service: ref.read(visitorLogCreateService)),
);

// TODO: 仮の内容なので、何も継承していないが、Controller の意味合いで
// Riverpod の StateNotifier（や AsyncNotifier？）を継承しても良さそう。
class VisitorLogCreateController {
  VisitorLogCreateController({required VisitorLogCreateService service})
      : _service = service;

  final VisitorLogCreateService _service;

  /// [VisitorLog] を作成する。
  Future<void> create() async {
    // TODO: 仮実装。
    await _service.create();
  }
}
