// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'festival_banner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FestivalBannerModel _$FestivalBannerModelFromJson(Map<String, dynamic> json) {
  return _FestivalBannerModel.fromJson(json);
}

/// @nodoc
mixin _$FestivalBannerModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<TagModel>? get tags => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int? get v => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FestivalBannerModelCopyWith<FestivalBannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FestivalBannerModelCopyWith<$Res> {
  factory $FestivalBannerModelCopyWith(
          FestivalBannerModel value, $Res Function(FestivalBannerModel) then) =
      _$FestivalBannerModelCopyWithImpl<$Res, FestivalBannerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      List<TagModel>? tags,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});
}

/// @nodoc
class _$FestivalBannerModelCopyWithImpl<$Res, $Val extends FestivalBannerModel>
    implements $FestivalBannerModelCopyWith<$Res> {
  _$FestivalBannerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FestivalBannerModelCopyWith<$Res>
    implements $FestivalBannerModelCopyWith<$Res> {
  factory _$$_FestivalBannerModelCopyWith(_$_FestivalBannerModel value,
          $Res Function(_$_FestivalBannerModel) then) =
      __$$_FestivalBannerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String title,
      List<TagModel>? tags,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});
}

/// @nodoc
class __$$_FestivalBannerModelCopyWithImpl<$Res>
    extends _$FestivalBannerModelCopyWithImpl<$Res, _$_FestivalBannerModel>
    implements _$$_FestivalBannerModelCopyWith<$Res> {
  __$$_FestivalBannerModelCopyWithImpl(_$_FestivalBannerModel _value,
      $Res Function(_$_FestivalBannerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? tags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_FestivalBannerModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FestivalBannerModel implements _FestivalBannerModel {
  const _$_FestivalBannerModel(
      {@JsonKey(name: '_id') this.id,
      required this.title,
      final List<TagModel>? tags,
      this.createdAt,
      this.updatedAt,
      @JsonKey(name: '__v') this.v})
      : _tags = tags;

  factory _$_FestivalBannerModel.fromJson(Map<String, dynamic> json) =>
      _$$_FestivalBannerModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String title;
  final List<TagModel>? _tags;
  @override
  List<TagModel>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey(name: '__v')
  final int? v;

  @override
  String toString() {
    return 'FestivalBannerModel(id: $id, title: $title, tags: $tags, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FestivalBannerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title,
      const DeepCollectionEquality().hash(_tags), createdAt, updatedAt, v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FestivalBannerModelCopyWith<_$_FestivalBannerModel> get copyWith =>
      __$$_FestivalBannerModelCopyWithImpl<_$_FestivalBannerModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FestivalBannerModelToJson(
      this,
    );
  }
}

abstract class _FestivalBannerModel implements FestivalBannerModel {
  const factory _FestivalBannerModel(
      {@JsonKey(name: '_id') final String? id,
      required final String title,
      final List<TagModel>? tags,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      @JsonKey(name: '__v') final int? v}) = _$_FestivalBannerModel;

  factory _FestivalBannerModel.fromJson(Map<String, dynamic> json) =
      _$_FestivalBannerModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get title;
  @override
  List<TagModel>? get tags;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(name: '__v')
  int? get v;
  @override
  @JsonKey(ignore: true)
  _$$_FestivalBannerModelCopyWith<_$_FestivalBannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
