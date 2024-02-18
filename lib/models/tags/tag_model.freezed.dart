// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return _TagModel.fromJson(json);
}

/// @nodoc
mixin _$TagModel {
  String get name => throw _privateConstructorUsedError;
  String? get imageUri => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  int? get v => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TagModelCopyWith<TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagModelCopyWith<$Res> {
  factory $TagModelCopyWith(TagModel value, $Res Function(TagModel) then) =
      _$TagModelCopyWithImpl<$Res, TagModel>;
  @useResult
  $Res call(
      {String name,
      String? imageUri,
      String category,
      @JsonKey(name: '_id') String? id,
      int? v});
}

/// @nodoc
class _$TagModelCopyWithImpl<$Res, $Val extends TagModel>
    implements $TagModelCopyWith<$Res> {
  _$TagModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUri = freezed,
    Object? category = null,
    Object? id = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: freezed == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TagModelCopyWith<$Res> implements $TagModelCopyWith<$Res> {
  factory _$$_TagModelCopyWith(
          _$_TagModel value, $Res Function(_$_TagModel) then) =
      __$$_TagModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? imageUri,
      String category,
      @JsonKey(name: '_id') String? id,
      int? v});
}

/// @nodoc
class __$$_TagModelCopyWithImpl<$Res>
    extends _$TagModelCopyWithImpl<$Res, _$_TagModel>
    implements _$$_TagModelCopyWith<$Res> {
  __$$_TagModelCopyWithImpl(
      _$_TagModel _value, $Res Function(_$_TagModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? imageUri = freezed,
    Object? category = null,
    Object? id = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_TagModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUri: freezed == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TagModel implements _TagModel {
  const _$_TagModel(
      {required this.name,
      this.imageUri,
      required this.category,
      @JsonKey(name: '_id') this.id,
      this.v});

  factory _$_TagModel.fromJson(Map<String, dynamic> json) =>
      _$$_TagModelFromJson(json);

  @override
  final String name;
  @override
  final String? imageUri;
  @override
  final String category;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final int? v;

  @override
  String toString() {
    return 'TagModel(name: $name, imageUri: $imageUri, category: $category, id: $id, v: $v)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TagModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUri, imageUri) ||
                other.imageUri == imageUri) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, imageUri, category, id, v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TagModelCopyWith<_$_TagModel> get copyWith =>
      __$$_TagModelCopyWithImpl<_$_TagModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TagModelToJson(
      this,
    );
  }
}

abstract class _TagModel implements TagModel {
  const factory _TagModel(
      {required final String name,
      final String? imageUri,
      required final String category,
      @JsonKey(name: '_id') final String? id,
      final int? v}) = _$_TagModel;

  factory _TagModel.fromJson(Map<String, dynamic> json) = _$_TagModel.fromJson;

  @override
  String get name;
  @override
  String? get imageUri;
  @override
  String get category;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  int? get v;
  @override
  @JsonKey(ignore: true)
  _$$_TagModelCopyWith<_$_TagModel> get copyWith =>
      throw _privateConstructorUsedError;
}
