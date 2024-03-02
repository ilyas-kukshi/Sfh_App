// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_banner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MainBannerModel _$MainBannerModelFromJson(Map<String, dynamic> json) {
  return _MainBannerModel.fromJson(json);
}

/// @nodoc
mixin _$MainBannerModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  String get imageUri => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  List<CategoryModel>? get categories => throw _privateConstructorUsedError;
  List<TagModel>? get tags => throw _privateConstructorUsedError;
  List<ProductModel>? get products => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int get v => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MainBannerModelCopyWith<MainBannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainBannerModelCopyWith<$Res> {
  factory $MainBannerModelCopyWith(
          MainBannerModel value, $Res Function(MainBannerModel) then) =
      _$MainBannerModelCopyWithImpl<$Res, MainBannerModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String imageUri,
      int position,
      List<CategoryModel>? categories,
      List<TagModel>? tags,
      List<ProductModel>? products,
      @JsonKey(name: '__v') int v});
}

/// @nodoc
class _$MainBannerModelCopyWithImpl<$Res, $Val extends MainBannerModel>
    implements $MainBannerModelCopyWith<$Res> {
  _$MainBannerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUri = null,
    Object? position = null,
    Object? categories = freezed,
    Object? tags = freezed,
    Object? products = freezed,
    Object? v = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUri: null == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MainBannerModelCopyWith<$Res>
    implements $MainBannerModelCopyWith<$Res> {
  factory _$$_MainBannerModelCopyWith(
          _$_MainBannerModel value, $Res Function(_$_MainBannerModel) then) =
      __$$_MainBannerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      String imageUri,
      int position,
      List<CategoryModel>? categories,
      List<TagModel>? tags,
      List<ProductModel>? products,
      @JsonKey(name: '__v') int v});
}

/// @nodoc
class __$$_MainBannerModelCopyWithImpl<$Res>
    extends _$MainBannerModelCopyWithImpl<$Res, _$_MainBannerModel>
    implements _$$_MainBannerModelCopyWith<$Res> {
  __$$_MainBannerModelCopyWithImpl(
      _$_MainBannerModel _value, $Res Function(_$_MainBannerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? imageUri = null,
    Object? position = null,
    Object? categories = freezed,
    Object? tags = freezed,
    Object? products = freezed,
    Object? v = null,
  }) {
    return _then(_$_MainBannerModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUri: null == imageUri
          ? _value.imageUri
          : imageUri // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MainBannerModel
    with DiagnosticableTreeMixin
    implements _MainBannerModel {
  const _$_MainBannerModel(
      {@JsonKey(name: '_id') this.id,
      required this.imageUri,
      required this.position,
      final List<CategoryModel>? categories,
      final List<TagModel>? tags,
      final List<ProductModel>? products,
      @JsonKey(name: '__v') required this.v})
      : _categories = categories,
        _tags = tags,
        _products = products;

  factory _$_MainBannerModel.fromJson(Map<String, dynamic> json) =>
      _$$_MainBannerModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final String imageUri;
  @override
  final int position;
  final List<CategoryModel>? _categories;
  @override
  List<CategoryModel>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<TagModel>? _tags;
  @override
  List<TagModel>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductModel>? _products;
  @override
  List<ProductModel>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: '__v')
  final int v;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MainBannerModel(id: $id, imageUri: $imageUri, position: $position, categories: $categories, tags: $tags, products: $products, v: $v)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MainBannerModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('imageUri', imageUri))
      ..add(DiagnosticsProperty('position', position))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('v', v));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MainBannerModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUri, imageUri) ||
                other.imageUri == imageUri) &&
            (identical(other.position, position) ||
                other.position == position) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      imageUri,
      position,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_products),
      v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MainBannerModelCopyWith<_$_MainBannerModel> get copyWith =>
      __$$_MainBannerModelCopyWithImpl<_$_MainBannerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MainBannerModelToJson(
      this,
    );
  }
}

abstract class _MainBannerModel implements MainBannerModel {
  const factory _MainBannerModel(
      {@JsonKey(name: '_id') final String? id,
      required final String imageUri,
      required final int position,
      final List<CategoryModel>? categories,
      final List<TagModel>? tags,
      final List<ProductModel>? products,
      @JsonKey(name: '__v') required final int v}) = _$_MainBannerModel;

  factory _MainBannerModel.fromJson(Map<String, dynamic> json) =
      _$_MainBannerModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  String get imageUri;
  @override
  int get position;
  @override
  List<CategoryModel>? get categories;
  @override
  List<TagModel>? get tags;
  @override
  List<ProductModel>? get products;
  @override
  @JsonKey(name: '__v')
  int get v;
  @override
  @JsonKey(ignore: true)
  _$$_MainBannerModelCopyWith<_$_MainBannerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
