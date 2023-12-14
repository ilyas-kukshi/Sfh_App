// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seller_register_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SellerRegisterModel _$SellerRegisterModelFromJson(Map<String, dynamic> json) {
  return _SellerRegisterModel.fromJson(json);
}

/// @nodoc
mixin _$SellerRegisterModel {
  String get name => throw _privateConstructorUsedError;
  String get businessName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get businessDescription => throw _privateConstructorUsedError;
  String get productTypes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SellerRegisterModelCopyWith<SellerRegisterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerRegisterModelCopyWith<$Res> {
  factory $SellerRegisterModelCopyWith(
          SellerRegisterModel value, $Res Function(SellerRegisterModel) then) =
      _$SellerRegisterModelCopyWithImpl<$Res, SellerRegisterModel>;
  @useResult
  $Res call(
      {String name,
      String businessName,
      String phoneNumber,
      String businessDescription,
      String productTypes});
}

/// @nodoc
class _$SellerRegisterModelCopyWithImpl<$Res, $Val extends SellerRegisterModel>
    implements $SellerRegisterModelCopyWith<$Res> {
  _$SellerRegisterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? businessName = null,
    Object? phoneNumber = null,
    Object? businessDescription = null,
    Object? productTypes = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      businessDescription: null == businessDescription
          ? _value.businessDescription
          : businessDescription // ignore: cast_nullable_to_non_nullable
              as String,
      productTypes: null == productTypes
          ? _value.productTypes
          : productTypes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SellerRegisterModelCopyWith<$Res>
    implements $SellerRegisterModelCopyWith<$Res> {
  factory _$$_SellerRegisterModelCopyWith(_$_SellerRegisterModel value,
          $Res Function(_$_SellerRegisterModel) then) =
      __$$_SellerRegisterModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String businessName,
      String phoneNumber,
      String businessDescription,
      String productTypes});
}

/// @nodoc
class __$$_SellerRegisterModelCopyWithImpl<$Res>
    extends _$SellerRegisterModelCopyWithImpl<$Res, _$_SellerRegisterModel>
    implements _$$_SellerRegisterModelCopyWith<$Res> {
  __$$_SellerRegisterModelCopyWithImpl(_$_SellerRegisterModel _value,
      $Res Function(_$_SellerRegisterModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? businessName = null,
    Object? phoneNumber = null,
    Object? businessDescription = null,
    Object? productTypes = null,
  }) {
    return _then(_$_SellerRegisterModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: null == businessName
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      businessDescription: null == businessDescription
          ? _value.businessDescription
          : businessDescription // ignore: cast_nullable_to_non_nullable
              as String,
      productTypes: null == productTypes
          ? _value.productTypes
          : productTypes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SellerRegisterModel implements _SellerRegisterModel {
  const _$_SellerRegisterModel(
      {required this.name,
      required this.businessName,
      required this.phoneNumber,
      required this.businessDescription,
      required this.productTypes});

  factory _$_SellerRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$$_SellerRegisterModelFromJson(json);

  @override
  final String name;
  @override
  final String businessName;
  @override
  final String phoneNumber;
  @override
  final String businessDescription;
  @override
  final String productTypes;

  @override
  String toString() {
    return 'SellerRegisterModel(name: $name, businessName: $businessName, phoneNumber: $phoneNumber, businessDescription: $businessDescription, productTypes: $productTypes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SellerRegisterModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.businessName, businessName) ||
                other.businessName == businessName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.businessDescription, businessDescription) ||
                other.businessDescription == businessDescription) &&
            (identical(other.productTypes, productTypes) ||
                other.productTypes == productTypes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, businessName, phoneNumber,
      businessDescription, productTypes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SellerRegisterModelCopyWith<_$_SellerRegisterModel> get copyWith =>
      __$$_SellerRegisterModelCopyWithImpl<_$_SellerRegisterModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SellerRegisterModelToJson(
      this,
    );
  }
}

abstract class _SellerRegisterModel implements SellerRegisterModel {
  const factory _SellerRegisterModel(
      {required final String name,
      required final String businessName,
      required final String phoneNumber,
      required final String businessDescription,
      required final String productTypes}) = _$_SellerRegisterModel;

  factory _SellerRegisterModel.fromJson(Map<String, dynamic> json) =
      _$_SellerRegisterModel.fromJson;

  @override
  String get name;
  @override
  String get businessName;
  @override
  String get phoneNumber;
  @override
  String get businessDescription;
  @override
  String get productTypes;
  @override
  @JsonKey(ignore: true)
  _$$_SellerRegisterModelCopyWith<_$_SellerRegisterModel> get copyWith =>
      throw _privateConstructorUsedError;
}
