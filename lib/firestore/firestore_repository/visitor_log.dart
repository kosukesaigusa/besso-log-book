import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../logger.dart';
import '../firestore_models/visitor_log.dart';
import '../firestore_refs.dart';

final visitorLogRepository =
    Provider.autoDispose((_) => VisitorLogRepository());

class VisitorLogRepository {
  /// 指定した [VisitorLog] を取得する。
  Future<VisitorLog?> fetchVisitorLog({
    required String visitorLogId,
  }) async {
    final ds = await visitorLogRef(visitorLogId: visitorLogId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data();
  }

  /// 指定した [VisitorLog] を購読する。
  Stream<VisitorLog?> subscribeVisitorLog({
    required String visitorLogId,
  }) {
    final docStream = visitorLogRef(visitorLogId: visitorLogId).snapshots();
    return docStream.map((ds) => ds.data());
  }

  /// [VisitorLog] 一覧を取得する。
  Future<List<VisitorLog>> fetchVisitorLogs() async {
    final qs = await visitorLogsRef
        // TODO: 必要性を確認して並び順やクエリを調整する。
        // TODO: パジネーションか無限スクロールに対応させても良いかも。
        .orderBy('createdAt', descending: true)
        .get();
    return qs.docs.map((qds) => qds.data()).toList();
  }

  /// [VisitorLog] 一覧を購読する。
  Stream<List<VisitorLog>> subscribeVisitorLogs() {
    return visitorLogsRef
        // TODO: 必要性を確認して並び順やクエリを調整する。
        // TODO: パジネーションか無限スクロールに対応させても良いかも。
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      return result;
    });
  }
}
