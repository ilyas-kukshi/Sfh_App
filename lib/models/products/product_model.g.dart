// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      imageUris:
          (json['imageUris'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      price: json['price'] as int,
      discount: json['discount'] as int,
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      available: json['available'] as bool,
      seller: UserModel.fromJson(json['seller'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      views: json['views'] as int?,
      enquired: json['enquired'] as int?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'imageUris': instance.imageUris,
      'name': instance.name,
      'price': instance.price,
      'discount': instance.discount,
      'category': instance.category,
      'available': instance.available,
      'seller': instance.seller,
      'tags': instance.tags,
      'views': instance.views,
      'enquired': instance.enquired,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
