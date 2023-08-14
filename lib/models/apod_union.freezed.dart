// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apod_union.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApodUnion {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Apod apod) apod,
    required TResult Function(List<Apod?> apodList) apodList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Apod apod)? apod,
    TResult? Function(List<Apod?> apodList)? apodList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Apod apod)? apod,
    TResult Function(List<Apod?> apodList)? apodList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApodSingle value) apod,
    required TResult Function(ApodList value) apodList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApodSingle value)? apod,
    TResult? Function(ApodList value)? apodList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApodSingle value)? apod,
    TResult Function(ApodList value)? apodList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApodUnionCopyWith<$Res> {
  factory $ApodUnionCopyWith(ApodUnion value, $Res Function(ApodUnion) then) =
      _$ApodUnionCopyWithImpl<$Res, ApodUnion>;
}

/// @nodoc
class _$ApodUnionCopyWithImpl<$Res, $Val extends ApodUnion>
    implements $ApodUnionCopyWith<$Res> {
  _$ApodUnionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ApodSingleCopyWith<$Res> {
  factory _$$ApodSingleCopyWith(
          _$ApodSingle value, $Res Function(_$ApodSingle) then) =
      __$$ApodSingleCopyWithImpl<$Res>;
  @useResult
  $Res call({Apod apod});
}

/// @nodoc
class __$$ApodSingleCopyWithImpl<$Res>
    extends _$ApodUnionCopyWithImpl<$Res, _$ApodSingle>
    implements _$$ApodSingleCopyWith<$Res> {
  __$$ApodSingleCopyWithImpl(
      _$ApodSingle _value, $Res Function(_$ApodSingle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apod = null,
  }) {
    return _then(_$ApodSingle(
      null == apod
          ? _value.apod
          : apod // ignore: cast_nullable_to_non_nullable
              as Apod,
    ));
  }
}

/// @nodoc

class _$ApodSingle implements ApodSingle {
  const _$ApodSingle(this.apod);

  @override
  final Apod apod;

  @override
  String toString() {
    return 'ApodUnion.apod(apod: $apod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApodSingle &&
            (identical(other.apod, apod) || other.apod == apod));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApodSingleCopyWith<_$ApodSingle> get copyWith =>
      __$$ApodSingleCopyWithImpl<_$ApodSingle>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Apod apod) apod,
    required TResult Function(List<Apod?> apodList) apodList,
  }) {
    return apod(this.apod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Apod apod)? apod,
    TResult? Function(List<Apod?> apodList)? apodList,
  }) {
    return apod?.call(this.apod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Apod apod)? apod,
    TResult Function(List<Apod?> apodList)? apodList,
    required TResult orElse(),
  }) {
    if (apod != null) {
      return apod(this.apod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApodSingle value) apod,
    required TResult Function(ApodList value) apodList,
  }) {
    return apod(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApodSingle value)? apod,
    TResult? Function(ApodList value)? apodList,
  }) {
    return apod?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApodSingle value)? apod,
    TResult Function(ApodList value)? apodList,
    required TResult orElse(),
  }) {
    if (apod != null) {
      return apod(this);
    }
    return orElse();
  }
}

abstract class ApodSingle implements ApodUnion {
  const factory ApodSingle(final Apod apod) = _$ApodSingle;

  Apod get apod;
  @JsonKey(ignore: true)
  _$$ApodSingleCopyWith<_$ApodSingle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApodListCopyWith<$Res> {
  factory _$$ApodListCopyWith(
          _$ApodList value, $Res Function(_$ApodList) then) =
      __$$ApodListCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Apod?> apodList});
}

/// @nodoc
class __$$ApodListCopyWithImpl<$Res>
    extends _$ApodUnionCopyWithImpl<$Res, _$ApodList>
    implements _$$ApodListCopyWith<$Res> {
  __$$ApodListCopyWithImpl(_$ApodList _value, $Res Function(_$ApodList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apodList = null,
  }) {
    return _then(_$ApodList(
      null == apodList
          ? _value._apodList
          : apodList // ignore: cast_nullable_to_non_nullable
              as List<Apod?>,
    ));
  }
}

/// @nodoc

class _$ApodList implements ApodList {
  const _$ApodList(final List<Apod?> apodList) : _apodList = apodList;

  final List<Apod?> _apodList;
  @override
  List<Apod?> get apodList {
    if (_apodList is EqualUnmodifiableListView) return _apodList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apodList);
  }

  @override
  String toString() {
    return 'ApodUnion.apodList(apodList: $apodList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApodList &&
            const DeepCollectionEquality().equals(other._apodList, _apodList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_apodList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApodListCopyWith<_$ApodList> get copyWith =>
      __$$ApodListCopyWithImpl<_$ApodList>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Apod apod) apod,
    required TResult Function(List<Apod?> apodList) apodList,
  }) {
    return apodList(this.apodList);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Apod apod)? apod,
    TResult? Function(List<Apod?> apodList)? apodList,
  }) {
    return apodList?.call(this.apodList);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Apod apod)? apod,
    TResult Function(List<Apod?> apodList)? apodList,
    required TResult orElse(),
  }) {
    if (apodList != null) {
      return apodList(this.apodList);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ApodSingle value) apod,
    required TResult Function(ApodList value) apodList,
  }) {
    return apodList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ApodSingle value)? apod,
    TResult? Function(ApodList value)? apodList,
  }) {
    return apodList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ApodSingle value)? apod,
    TResult Function(ApodList value)? apodList,
    required TResult orElse(),
  }) {
    if (apodList != null) {
      return apodList(this);
    }
    return orElse();
  }
}

abstract class ApodList implements ApodUnion {
  const factory ApodList(final List<Apod?> apodList) = _$ApodList;

  List<Apod?> get apodList;
  @JsonKey(ignore: true)
  _$$ApodListCopyWith<_$ApodList> get copyWith =>
      throw _privateConstructorUsedError;
}
