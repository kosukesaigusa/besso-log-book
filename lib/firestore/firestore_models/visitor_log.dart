import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_json_converters/flutterfire_json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor_log.freezed.dart';
part 'visitor_log.g.dart';

@freezed
class VisitorLog with _$VisitorLog {
  const factory VisitorLog({
    @Default('') String visitorLogId,
    @Default('') String visitorName,
    @Default('') String description,
    @Default('') String imageUrl,
    @alwaysUseServerTimestampSealedTimestampConverter
    @Default(ServerTimestamp())
    SealedTimestamp createdAt,
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
