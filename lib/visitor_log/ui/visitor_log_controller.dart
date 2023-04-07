import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firestore/firestore_models/visitor_log.dart';
import '../visitor_log.dart';

/// 購読された [VisitorLog] 一覧を返す [StreamProvider]。
/// たとえば [VisitorLogController] に [StateNotifier] などを継承させた上で、
/// `subscribe` のようなメソッドを定義し、ローディング状態と取得された
/// [VisitorLog] を管理しても良いが、そのあたりを UI から
/// `ref.watch(visitorLogs).when()` とするだけで良い [StreamProvider] が
/// 使いやすいと判断してこのように切り出した。
/// なお、やや冗長だが、コントローラから `Repository` と直接やり取りしないように
/// しているので、内部では [VisitorLogService] のメソッドを使用する。
final visitorLogs = StreamProvider.autoDispose<List<VisitorLog>>((ref) {
  final service = ref.watch(visitorLogService);
  return service.subscribe();
});

final visitorLogCreateController = Provider.autoDispose<VisitorLogController>(
  (ref) => VisitorLogController(service: ref.watch(visitorLogService)),
);

/// [VisitorLog] に関する操作（主に書き込み系）を担当するコントローラ。
/// ユーザーによる入力を解釈して、サービスクラスと通信をして然るべき操作を行う。
/// UI とモデルの分離を明確にするために、やや冗長だが、このような構成にしている。
class VisitorLogController {
  VisitorLogController({required VisitorLogService service})
      : _service = service;

  final VisitorLogService _service;

  /// [VisitorLog] を作成する。
  Future<void> create({
    required String visitorName,
    required String description,
    required String imageUrl,
  }) async {
    // TODO: 仮実装。エラーハンドリングなど。
    await _service.create(
      visitorName: visitorName,
      description: description,
      imageUrl: imageUrl,
    );
  }

  /// 指定した [VisitorLog] を削除する。
  Future<void> delete({required VisitorLog visitorLog}) async {
    // TODO: 仮実装。エラーハンドリングなど。
    await _service.delete(visitorLog: visitorLog);
  }
}
