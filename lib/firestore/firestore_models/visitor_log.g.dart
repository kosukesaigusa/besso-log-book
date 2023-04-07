// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VisitorLog _$$_VisitorLogFromJson(Map<String, dynamic> json) =>
    _$_VisitorLog(
      visitorLogId: json['visitorLogId'] as String? ?? '',
      visitorName: json['visitorName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? const UnionTimestamp.serverTimestamp()
          : alwaysUseServerTimestampUnionTimestampConverter
              .fromJson(json['createdAt'] as Object),
    );

Map<String, dynamic> _$$_VisitorLogToJson(_$_VisitorLog instance) =>
    <String, dynamic>{
      'visitorLogId': instance.visitorLogId,
      'visitorName': instance.visitorName,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'createdAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.createdAt),
    };
