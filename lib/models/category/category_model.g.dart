// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CategoryModel _$$_CategoryModelFromJson(Map<String, dynamic> json) =>
    _$_CategoryModel(
      name: json['name'] as String,
      imageUri: json['imageUri'] as String?,
      popular: json['popular'] as bool?,
      subCategories: json['subCategories'] as List<dynamic>?,
      products: json['products'] as List<dynamic>?,
      id: json['_id'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$$_CategoryModelToJson(_$_CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUri': instance.imageUri,
      'popular': instance.popular,
      'subCategories': instance.subCategories,
      'products': instance.products,
      '_id': instance.id,
      'v': instance.v,
    };
