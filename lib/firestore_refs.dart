import 'package:cloud_firestore/cloud_firestore.dart';

import 'visitor_log/visitor_log.dart';

final _db = FirebaseFirestore.instance;

/// visitorLogs コレクションの参照。
final visitorLogsRef = _db.collection('visitorLogs').withConverter(
  fromFirestore: (ds, _) {
    return VisitorLog.fromDocumentSnapshot(ds);
  },
  toFirestore: (obj, _) {
    final json = obj.toJson();
    return json;
  },
);

/// visitorLog ドキュメントの参照。
DocumentReference<VisitorLog> visitorLogRef({required String visitorLogId}) =>
    visitorLogsRef.doc(visitorLogId);
