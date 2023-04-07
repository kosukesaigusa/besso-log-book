// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VisitorLog _$VisitorLogFromJson(Map<String, dynamic> json) {
  return _VisitorLog.fromJson(json);
}

/// @nodoc
mixin _$VisitorLog {
  String get visitorLogId => throw _privateConstructorUsedError;
  String get visitorName => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VisitorLogCopyWith<VisitorLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitorLogCopyWith<$Res> {
  factory $VisitorLogCopyWith(
          VisitorLog value, $Res Function(VisitorLog) then) =
      _$VisitorLogCopyWithImpl<$Res, VisitorLog>;
  @useResult
  $Res call(
      {String visitorLogId,
      String visitorName,
      String description,
      String imageUrl,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$VisitorLogCopyWithImpl<$Res, $Val extends VisitorLog>
    implements $VisitorLogCopyWith<$Res> {
  _$VisitorLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitorLogId = null,
    Object? visitorName = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      visitorLogId: null == visitorLogId
          ? _value.visitorLogId
          : visitorLogId // ignore: cast_nullable_to_non_nullable
              as String,
      visitorName: null == visitorName
          ? _value.visitorName
          : visitorName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_VisitorLogCopyWith<$Res>
    implements $VisitorLogCopyWith<$Res> {
  factory _$$_VisitorLogCopyWith(
          _$_VisitorLog value, $Res Function(_$_VisitorLog) then) =
      __$$_VisitorLogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String visitorLogId,
      String visitorName,
      String description,
      String imageUrl,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_VisitorLogCopyWithImpl<$Res>
    extends _$VisitorLogCopyWithImpl<$Res, _$_VisitorLog>
    implements _$$_VisitorLogCopyWith<$Res> {
  __$$_VisitorLogCopyWithImpl(
      _$_VisitorLog _value, $Res Function(_$_VisitorLog) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitorLogId = null,
    Object? visitorName = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? createdAt = null,
  }) {
    return _then(_$_VisitorLog(
      visitorLogId: null == visitorLogId
          ? _value.visitorLogId
          : visitorLogId // ignore: cast_nullable_to_non_nullable
              as String,
      visitorName: null == visitorName
          ? _value.visitorName
          : visitorName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VisitorLog extends _VisitorLog {
  const _$_VisitorLog(
      {this.visitorLogId = '',
      this.visitorName = '',
      this.description = '',
      this.imageUrl = '',
      @alwaysUseServerTimestampUnionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp()})
      : super._();

  factory _$_VisitorLog.fromJson(Map<String, dynamic> json) =>
      _$$_VisitorLogFromJson(json);

  @override
  @JsonKey()
  final String visitorLogId;
  @override
  @JsonKey()
  final String visitorName;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String imageUrl;
  @override
  @JsonKey()
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'VisitorLog(visitorLogId: $visitorLogId, visitorName: $visitorName, description: $description, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VisitorLog &&
            (identical(other.visitorLogId, visitorLogId) ||
                other.visitorLogId == visitorLogId) &&
            (identical(other.visitorName, visitorName) ||
                other.visitorName == visitorName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, visitorLogId, visitorName, description, imageUrl, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VisitorLogCopyWith<_$_VisitorLog> get copyWith =>
      __$$_VisitorLogCopyWithImpl<_$_VisitorLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VisitorLogToJson(
      this,
    );
  }
}

abstract class _VisitorLog extends VisitorLog {
  const factory _VisitorLog(
      {final String visitorLogId,
      final String visitorName,
      final String description,
      final String imageUrl,
      @alwaysUseServerTimestampUnionTimestampConverter
          final UnionTimestamp createdAt}) = _$_VisitorLog;
  const _VisitorLog._() : super._();

  factory _VisitorLog.fromJson(Map<String, dynamic> json) =
      _$_VisitorLog.fromJson;

  @override
  String get visitorLogId;
  @override
  String get visitorName;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_VisitorLogCopyWith<_$_VisitorLog> get copyWith =>
      throw _privateConstructorUsedError;
}
