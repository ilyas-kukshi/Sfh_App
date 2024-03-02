// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MainBannerModel _$$_MainBannerModelFromJson(Map<String, dynamic> json) =>
    _$_MainBannerModel(
      id: json['_id'] as String?,
      imageUri: json['imageUri'] as String,
      position: json['position'] as int,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$$_MainBannerModelToJson(_$_MainBannerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'imageUri': instance.imageUri,
      'position': instance.position,
      'categories': instance.categories,
      'tags': instance.tags,
      'products': instance.products,
      '__v': instance.v,
    };
