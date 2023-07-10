import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_models/visitor_log.dart';

final _db = FirebaseFirestore.instance;

/// visitorLogs コレクションの参照。
final visitorLogsRef = _db.collection('visitorLogs').withConverter<VisitorLog>(
      fromFirestore: (ds, _) {
        return VisitorLog.fromDocumentSnapshot(ds);
      },
      toFirestore: (obj, _) => obj.toJson(),
    );

/// visitorLog ドキュメントの参照。
DocumentReference<VisitorLog> visitorLogRef({required String visitorLogId}) =>
    visitorLogsRef.doc(visitorLogId);
