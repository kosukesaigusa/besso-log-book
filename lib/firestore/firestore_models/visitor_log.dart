import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../json_converters/union_timestamp.dart';

part 'visitor_log.freezed.dart';
part 'visitor_log.g.dart';

@freezed
class VisitorLog with _$VisitorLog {
  const factory VisitorLog({
    @Default('') String visitorName,
    @Default('') String description,
    @Default('') String imageUrl,
    @alwaysUseServerTimestampUnionTimestampConverter
    @Default(UnionTimestamp.serverTimestamp())
        UnionTimestamp createdAt,
  }) = _VisitorLog;

  factory VisitorLog.fromJson(Map<String, dynamic> json) =>
      _$VisitorLogFromJson(json);

  factory VisitorLog.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return VisitorLog.fromJson(<String, dynamic>{
      ...data,
      'visitorLogId': ds.id,
    });
  }

  const VisitorLog._();
}
