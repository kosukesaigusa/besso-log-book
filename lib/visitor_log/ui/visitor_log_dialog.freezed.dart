// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visitor_log_dialog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$VisitorLogDialogType {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VisitorLog visitorLog) read,
    required TResult Function() create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VisitorLog visitorLog)? read,
    TResult? Function()? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VisitorLog visitorLog)? read,
    TResult Function()? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Read value) read,
    required TResult Function(Create value) create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Read value)? read,
    TResult? Function(Create value)? create,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Read value)? read,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitorLogDialogTypeCopyWith<$Res> {
  factory $VisitorLogDialogTypeCopyWith(VisitorLogDialogType value,
          $Res Function(VisitorLogDialogType) then) =
      _$VisitorLogDialogTypeCopyWithImpl<$Res, VisitorLogDialogType>;
}

/// @nodoc
class _$VisitorLogDialogTypeCopyWithImpl<$Res,
        $Val extends VisitorLogDialogType>
    implements $VisitorLogDialogTypeCopyWith<$Res> {
  _$VisitorLogDialogTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ReadCopyWith<$Res> {
  factory _$$ReadCopyWith(_$Read value, $Res Function(_$Read) then) =
      __$$ReadCopyWithImpl<$Res>;
  @useResult
  $Res call({VisitorLog visitorLog});

  $VisitorLogCopyWith<$Res> get visitorLog;
}

/// @nodoc
class __$$ReadCopyWithImpl<$Res>
    extends _$VisitorLogDialogTypeCopyWithImpl<$Res, _$Read>
    implements _$$ReadCopyWith<$Res> {
  __$$ReadCopyWithImpl(_$Read _value, $Res Function(_$Read) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? visitorLog = null,
  }) {
    return _then(_$Read(
      visitorLog: null == visitorLog
          ? _value.visitorLog
          : visitorLog // ignore: cast_nullable_to_non_nullable
              as VisitorLog,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $VisitorLogCopyWith<$Res> get visitorLog {
    return $VisitorLogCopyWith<$Res>(_value.visitorLog, (value) {
      return _then(_value.copyWith(visitorLog: value));
    });
  }
}

/// @nodoc

class _$Read implements Read {
  const _$Read({required this.visitorLog});

  @override
  final VisitorLog visitorLog;

  @override
  String toString() {
    return 'VisitorLogDialogType.read(visitorLog: $visitorLog)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Read &&
            (identical(other.visitorLog, visitorLog) ||
                other.visitorLog == visitorLog));
  }

  @override
  int get hashCode => Object.hash(runtimeType, visitorLog);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadCopyWith<_$Read> get copyWith =>
      __$$ReadCopyWithImpl<_$Read>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VisitorLog visitorLog) read,
    required TResult Function() create,
  }) {
    return read(visitorLog);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VisitorLog visitorLog)? read,
    TResult? Function()? create,
  }) {
    return read?.call(visitorLog);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VisitorLog visitorLog)? read,
    TResult Function()? create,
    required TResult orElse(),
  }) {
    if (read != null) {
      return read(visitorLog);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Read value) read,
    required TResult Function(Create value) create,
  }) {
    return read(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Read value)? read,
    TResult? Function(Create value)? create,
  }) {
    return read?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Read value)? read,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) {
    if (read != null) {
      return read(this);
    }
    return orElse();
  }
}

abstract class Read implements VisitorLogDialogType {
  const factory Read({required final VisitorLog visitorLog}) = _$Read;

  VisitorLog get visitorLog;
  @JsonKey(ignore: true)
  _$$ReadCopyWith<_$Read> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateCopyWith<$Res> {
  factory _$$CreateCopyWith(_$Create value, $Res Function(_$Create) then) =
      __$$CreateCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateCopyWithImpl<$Res>
    extends _$VisitorLogDialogTypeCopyWithImpl<$Res, _$Create>
    implements _$$CreateCopyWith<$Res> {
  __$$CreateCopyWithImpl(_$Create _value, $Res Function(_$Create) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Create implements Create {
  const _$Create();

  @override
  String toString() {
    return 'VisitorLogDialogType.create()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Create);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VisitorLog visitorLog) read,
    required TResult Function() create,
  }) {
    return create();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VisitorLog visitorLog)? read,
    TResult? Function()? create,
  }) {
    return create?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VisitorLog visitorLog)? read,
    TResult Function()? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Read value) read,
    required TResult Function(Create value) create,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Read value)? read,
    TResult? Function(Create value)? create,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Read value)? read,
    TResult Function(Create value)? create,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class Create implements VisitorLogDialogType {
  const factory Create() = _$Create;
}
