import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firestore_models/visitor_log.dart';
import '../firestore_refs.dart';

final visitorLogRepositoryProvider =
    Provider.autoDispose((_) => VisitorLogRepository());

class VisitorLogRepository {
  /// [VisitorLog] を作成する。
  Future<void> createVisitorLog({required VisitorLog visitorLog}) =>
      visitorLogsRef.add(visitorLog);

  /// 指定した [VisitorLog] を購読する。
  Stream<VisitorLog?> subscribeVisitorLog({
    required String visitorLogId,
  }) {
    final docStream = visitorLogRef(visitorLogId: visitorLogId).snapshots();
    return docStream.map((ds) => ds.data());
  }

  /// [VisitorLog] 一覧を購読する。
  Stream<List<VisitorLog>> subscribeVisitorLogs() {
    return visitorLogsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      return result;
    });
  }

  /// 指定した [VisitorLog] を削除する。
  Future<void> deleteVisitorLog({required String visitorLogId}) =>
      visitorLogRef(visitorLogId: visitorLogId).delete();
}
