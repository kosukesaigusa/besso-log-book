import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firestore/firestore_models/visitor_log.dart';
import '../firestore/firestore_repository/visitor_log.dart';

final visitorLogService = Provider.autoDispose<VisitorLogService>(
  (ref) =>
      VisitorLogService(visitorLogRepository: ref.watch(visitorLogRepository)),
);

/// [VisitorLog] に関するサービス（モデル）クラス。
/// いわゆるビジネスロジックはここに記述する。環境や UI に依存せず、可能な限り
/// 純粋な Dart で記述するようにする。
class VisitorLogService {
  VisitorLogService({required VisitorLogRepository visitorLogRepository})
      : _visitorLogRepository = visitorLogRepository;

  final VisitorLogRepository _visitorLogRepository;

  /// [VisitorLog] 一覧を購読する。
  Stream<List<VisitorLog>> subscribe() =>
      _visitorLogRepository.subscribeVisitorLogs();

  /// [VisitorLog] を作成する。
  Future<void> create({
    required String visitorName,
    required String description,
    required String imageUrl,
  }) async {
    // TODO: 仮実装。
    final visitorLog = VisitorLog(
      visitorName: visitorName,
      description: description,
      imageUrl: imageUrl,
    );
    await _visitorLogRepository.createVisitorLog(visitorLog: visitorLog);
  }

  /// 指定した [VisitorLog] を削除する。
  Future<void> delete({required VisitorLog visitorLog}) async {
    // TODO: 仮実装。
    await _visitorLogRepository.deleteVisitorLog(
      visitorLogId: visitorLog.visitorLogId,
    );
  }
}
