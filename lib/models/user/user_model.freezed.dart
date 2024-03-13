// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  int get productLimit => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<String>? get categoryAccess => throw _privateConstructorUsedError;
  List<ProductModel>? get wishlist => throw _privateConstructorUsedError;
  List<ProductModel>? get mycart => throw _privateConstructorUsedError;
  List<ProductModel>? get recentlyViewed => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int? get v => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String phoneNumber,
      String role,
      int productLimit,
      String? name,
      List<String>? categoryAccess,
      List<ProductModel>? wishlist,
      List<ProductModel>? mycart,
      List<ProductModel>? recentlyViewed,
      @JsonKey(name: '_id') String? id,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? role = null,
    Object? productLimit = null,
    Object? name = freezed,
    Object? categoryAccess = freezed,
    Object? wishlist = freezed,
    Object? mycart = freezed,
    Object? recentlyViewed = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      productLimit: null == productLimit
          ? _value.productLimit
          : productLimit // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryAccess: freezed == categoryAccess
          ? _value.categoryAccess
          : categoryAccess // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      wishlist: freezed == wishlist
          ? _value.wishlist
          : wishlist // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      mycart: freezed == mycart
          ? _value.mycart
          : mycart // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      recentlyViewed: freezed == recentlyViewed
          ? _value.recentlyViewed
          : recentlyViewed // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
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
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String phoneNumber,
      String role,
      int productLimit,
      String? name,
      List<String>? categoryAccess,
      List<ProductModel>? wishlist,
      List<ProductModel>? mycart,
      List<ProductModel>? recentlyViewed,
      @JsonKey(name: '_id') String? id,
      DateTime? createdAt,
      DateTime? updatedAt,
      @JsonKey(name: '__v') int? v});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? role = null,
    Object? productLimit = null,
    Object? name = freezed,
    Object? categoryAccess = freezed,
    Object? wishlist = freezed,
    Object? mycart = freezed,
    Object? recentlyViewed = freezed,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
  }) {
    return _then(_$_UserModel(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      productLimit: null == productLimit
          ? _value.productLimit
          : productLimit // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryAccess: freezed == categoryAccess
          ? _value._categoryAccess
          : categoryAccess // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      wishlist: freezed == wishlist
          ? _value._wishlist
          : wishlist // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      mycart: freezed == mycart
          ? _value._mycart
          : mycart // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
      recentlyViewed: freezed == recentlyViewed
          ? _value._recentlyViewed
          : recentlyViewed // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>?,
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
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {required this.phoneNumber,
      required this.role,
      required this.productLimit,
      this.name,
      final List<String>? categoryAccess,
      final List<ProductModel>? wishlist,
      final List<ProductModel>? mycart,
      final List<ProductModel>? recentlyViewed,
      @JsonKey(name: '_id') this.id,
      this.createdAt,
      this.updatedAt,
      @JsonKey(name: '__v') this.v})
      : _categoryAccess = categoryAccess,
        _wishlist = wishlist,
        _mycart = mycart,
        _recentlyViewed = recentlyViewed;

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String role;
  @override
  final int productLimit;
  @override
  final String? name;
  final List<String>? _categoryAccess;
  @override
  List<String>? get categoryAccess {
    final value = _categoryAccess;
    if (value == null) return null;
    if (_categoryAccess is EqualUnmodifiableListView) return _categoryAccess;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductModel>? _wishlist;
  @override
  List<ProductModel>? get wishlist {
    final value = _wishlist;
    if (value == null) return null;
    if (_wishlist is EqualUnmodifiableListView) return _wishlist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductModel>? _mycart;
  @override
  List<ProductModel>? get mycart {
    final value = _mycart;
    if (value == null) return null;
    if (_mycart is EqualUnmodifiableListView) return _mycart;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ProductModel>? _recentlyViewed;
  @override
  List<ProductModel>? get recentlyViewed {
    final value = _recentlyViewed;
    if (value == null) return null;
    if (_recentlyViewed is EqualUnmodifiableListView) return _recentlyViewed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
    return 'UserModel(phoneNumber: $phoneNumber, role: $role, productLimit: $productLimit, name: $name, categoryAccess: $categoryAccess, wishlist: $wishlist, mycart: $mycart, recentlyViewed: $recentlyViewed, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.productLimit, productLimit) ||
                other.productLimit == productLimit) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._categoryAccess, _categoryAccess) &&
            const DeepCollectionEquality().equals(other._wishlist, _wishlist) &&
            const DeepCollectionEquality().equals(other._mycart, _mycart) &&
            const DeepCollectionEquality()
                .equals(other._recentlyViewed, _recentlyViewed) &&
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
      phoneNumber,
      role,
      productLimit,
      name,
      const DeepCollectionEquality().hash(_categoryAccess),
      const DeepCollectionEquality().hash(_wishlist),
      const DeepCollectionEquality().hash(_mycart),
      const DeepCollectionEquality().hash(_recentlyViewed),
      id,
      createdAt,
      updatedAt,
      v);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String phoneNumber,
      required final String role,
      required final int productLimit,
      final String? name,
      final List<String>? categoryAccess,
      final List<ProductModel>? wishlist,
      final List<ProductModel>? mycart,
      final List<ProductModel>? recentlyViewed,
      @JsonKey(name: '_id') final String? id,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      @JsonKey(name: '__v') final int? v}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get phoneNumber;
  @override
  String get role;
  @override
  int get productLimit;
  @override
  String? get name;
  @override
  List<String>? get categoryAccess;
  @override
  List<ProductModel>? get wishlist;
  @override
  List<ProductModel>? get mycart;
  @override
  List<ProductModel>? get recentlyViewed;
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
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
