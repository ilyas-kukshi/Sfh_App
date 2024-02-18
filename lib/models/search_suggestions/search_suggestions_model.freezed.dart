// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_suggestions_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchSuggestionsModel _$SearchSuggestionsModelFromJson(
    Map<String, dynamic> json) {
  return _SearchSuggestionsModel.fromJson(json);
}

/// @nodoc
mixin _$SearchSuggestionsModel {
  String get type => throw _privateConstructorUsedError;
  ProductModel? get product => throw _privateConstructorUsedError;
  CategoryModel? get category => throw _privateConstructorUsedError;
  TagModel? get tag => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchSuggestionsModelCopyWith<SearchSuggestionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchSuggestionsModelCopyWith<$Res> {
  factory $SearchSuggestionsModelCopyWith(SearchSuggestionsModel value,
          $Res Function(SearchSuggestionsModel) then) =
      _$SearchSuggestionsModelCopyWithImpl<$Res, SearchSuggestionsModel>;
  @useResult
  $Res call(
      {String type,
      ProductModel? product,
      CategoryModel? category,
      TagModel? tag});

  $ProductModelCopyWith<$Res>? get product;
  $CategoryModelCopyWith<$Res>? get category;
  $TagModelCopyWith<$Res>? get tag;
}

/// @nodoc
class _$SearchSuggestionsModelCopyWithImpl<$Res,
        $Val extends SearchSuggestionsModel>
    implements $SearchSuggestionsModelCopyWith<$Res> {
  _$SearchSuggestionsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? product = freezed,
    Object? category = freezed,
    Object? tag = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as TagModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductModelCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryModelCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryModelCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TagModelCopyWith<$Res>? get tag {
    if (_value.tag == null) {
      return null;
    }

    return $TagModelCopyWith<$Res>(_value.tag!, (value) {
      return _then(_value.copyWith(tag: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SearchSuggestionsModelCopyWith<$Res>
    implements $SearchSuggestionsModelCopyWith<$Res> {
  factory _$$_SearchSuggestionsModelCopyWith(_$_SearchSuggestionsModel value,
          $Res Function(_$_SearchSuggestionsModel) then) =
      __$$_SearchSuggestionsModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      ProductModel? product,
      CategoryModel? category,
      TagModel? tag});

  @override
  $ProductModelCopyWith<$Res>? get product;
  @override
  $CategoryModelCopyWith<$Res>? get category;
  @override
  $TagModelCopyWith<$Res>? get tag;
}

/// @nodoc
class __$$_SearchSuggestionsModelCopyWithImpl<$Res>
    extends _$SearchSuggestionsModelCopyWithImpl<$Res,
        _$_SearchSuggestionsModel>
    implements _$$_SearchSuggestionsModelCopyWith<$Res> {
  __$$_SearchSuggestionsModelCopyWithImpl(_$_SearchSuggestionsModel _value,
      $Res Function(_$_SearchSuggestionsModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? product = freezed,
    Object? category = freezed,
    Object? tag = freezed,
  }) {
    return _then(_$_SearchSuggestionsModel(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as ProductModel?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryModel?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as TagModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SearchSuggestionsModel implements _SearchSuggestionsModel {
  const _$_SearchSuggestionsModel(
      {required this.type, this.product, this.category, this.tag});

  factory _$_SearchSuggestionsModel.fromJson(Map<String, dynamic> json) =>
      _$$_SearchSuggestionsModelFromJson(json);

  @override
  final String type;
  @override
  final ProductModel? product;
  @override
  final CategoryModel? category;
  @override
  final TagModel? tag;

  @override
  String toString() {
    return 'SearchSuggestionsModel(type: $type, product: $product, category: $category, tag: $tag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchSuggestionsModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, product, category, tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchSuggestionsModelCopyWith<_$_SearchSuggestionsModel> get copyWith =>
      __$$_SearchSuggestionsModelCopyWithImpl<_$_SearchSuggestionsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchSuggestionsModelToJson(
      this,
    );
  }
}

abstract class _SearchSuggestionsModel implements SearchSuggestionsModel {
  const factory _SearchSuggestionsModel(
      {required final String type,
      final ProductModel? product,
      final CategoryModel? category,
      final TagModel? tag}) = _$_SearchSuggestionsModel;

  factory _SearchSuggestionsModel.fromJson(Map<String, dynamic> json) =
      _$_SearchSuggestionsModel.fromJson;

  @override
  String get type;
  @override
  ProductModel? get product;
  @override
  CategoryModel? get category;
  @override
  TagModel? get tag;
  @override
  @JsonKey(ignore: true)
  _$$_SearchSuggestionsModelCopyWith<_$_SearchSuggestionsModel> get copyWith =>
      throw _privateConstructorUsedError;
}
