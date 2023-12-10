// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  List<String> get imageUris => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  int get discount => throw _privateConstructorUsedError;
  CategoryModel get category => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;
  UserModel get seller => throw _privateConstructorUsedError;
  List<TagModel>? get tags => throw _privateConstructorUsedError;
  int? get views => throw _privateConstructorUsedError;
  int? get enquired => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int? get v => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {List<String> imageUris,
      String name,
      int price,
      int discount,
      CategoryModel category,
      bool available,
      UserModel seller,
      List<TagModel>? tags,
      int? views,
      int? enquired,
      @JsonKey(name: '_id') String? id,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});

  $CategoryModelCopyWith<$Res> get category;
  $UserModelCopyWith<$Res> get seller;
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUris = null,
    Object? name = null,
    Object? price = null,
    Object? discount = null,
    Object? category = null,
    Object? available = null,
    Object? seller = null,
    Object? tags = freezed,
    Object? views = freezed,
    Object? enquired = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      imageUris: null == imageUris
          ? _value.imageUris
          : imageUris // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      seller: null == seller
          ? _value.seller
          : seller // ignore: cast_nullable_to_non_nullable
              as UserModel,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      enquired: freezed == enquired
          ? _value.enquired
          : enquired // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res> get category {
    return $CategoryModelCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get seller {
    return $UserModelCopyWith<$Res>(_value.seller, (value) {
      return _then(_value.copyWith(seller: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ProductModelCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$_ProductModelCopyWith(
          _$_ProductModel value, $Res Function(_$_ProductModel) then) =
      __$$_ProductModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> imageUris,
      String name,
      int price,
      int discount,
      CategoryModel category,
      bool available,
      UserModel seller,
      List<TagModel>? tags,
      int? views,
      int? enquired,
      @JsonKey(name: '_id') String? id,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});

  @override
  $CategoryModelCopyWith<$Res> get category;
  @override
  $UserModelCopyWith<$Res> get seller;
}

/// @nodoc
class __$$_ProductModelCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$_ProductModel>
    implements _$$_ProductModelCopyWith<$Res> {
  __$$_ProductModelCopyWithImpl(
      _$_ProductModel _value, $Res Function(_$_ProductModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUris = null,
    Object? name = null,
    Object? price = null,
    Object? discount = null,
    Object? category = null,
    Object? available = null,
    Object? seller = null,
    Object? tags = freezed,
    Object? views = freezed,
    Object? enquired = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_ProductModel(
      imageUris: null == imageUris
          ? _value._imageUris
          : imageUris // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      seller: null == seller
          ? _value.seller
          : seller // ignore: cast_nullable_to_non_nullable
              as UserModel,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<TagModel>?,
      views: freezed == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      enquired: freezed == enquired
          ? _value.enquired
          : enquired // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_ProductModel implements _ProductModel {
  const _$_ProductModel(
      {required final List<String> imageUris,
      required this.name,
      required this.price,
      required this.discount,
      required this.category,
      required this.available,
      required this.seller,
      final List<TagModel>? tags,
      this.views,
      this.enquired,
      @JsonKey(name: '_id') this.id,
      this.createdAt,
      this.updatedAt,
      @JsonKey(name: '__v') this.v})
      : _imageUris = imageUris,
        _tags = tags;

  factory _$_ProductModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProductModelFromJson(json);

  final List<String> _imageUris;
  @override
  List<String> get imageUris {
    if (_imageUris is EqualUnmodifiableListView) return _imageUris;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUris);
  }

  @override
  final String name;
  @override
  final int price;
  @override
  final int discount;
  @override
  final CategoryModel category;
  @override
  final bool available;
  @override
  final UserModel seller;
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
  final int? views;
  @override
  final int? enquired;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey(name: '__v')
  final int? v;

  @override
  String toString() {
    return 'ProductModel(imageUris: $imageUris, name: $name, price: $price, discount: $discount, category: $category, available: $available, seller: $seller, tags: $tags, views: $views, enquired: $enquired, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProductModel &&
            const DeepCollectionEquality()
                .equals(other._imageUris, _imageUris) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.seller, seller) || other.seller == seller) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.enquired, enquired) ||
                other.enquired == enquired) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.v, v) || other.v == v));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_imageUris),
      name,
      price,
      discount,
      category,
      available,
      seller,
      const DeepCollectionEquality().hash(_tags),
      views,
      enquired,
      id,
      createdAt,
      updatedAt,
      v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      __$$_ProductModelCopyWithImpl<_$_ProductModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductModelToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductModel {
  const factory _ProductModel(
      {required final List<String> imageUris,
      required final String name,
      required final int price,
      required final int discount,
      required final CategoryModel category,
      required final bool available,
      required final UserModel seller,
      final List<TagModel>? tags,
      final int? views,
      final int? enquired,
      @JsonKey(name: '_id') final String? id,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      @JsonKey(name: '__v') final int? v}) = _$_ProductModel;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$_ProductModel.fromJson;

  @override
  List<String> get imageUris;
  @override
  String get name;
  @override
  int get price;
  @override
  int get discount;
  @override
  CategoryModel get category;
  @override
  bool get available;
  @override
  UserModel get seller;
  @override
  List<TagModel>? get tags;
  @override
  int? get views;
  @override
  int? get enquired;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(name: '__v')
  int? get v;
  @override
  @JsonKey(ignore: true)
  _$$_ProductModelCopyWith<_$_ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}
