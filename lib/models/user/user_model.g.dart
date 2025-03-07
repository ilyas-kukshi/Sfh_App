// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      productLimit: json['productLimit'] as int?,
      name: json['name'] as String?,
      categoryAccess: (json['categoryAccess'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      wishlist: (json['wishlist'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mycart: (json['mycart'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recentlyViewed: (json['recentlyViewed'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'productLimit': instance.productLimit,
      'name': instance.name,
      'categoryAccess': instance.categoryAccess,
      'wishlist': instance.wishlist,
      'mycart': instance.mycart,
      'recentlyViewed': instance.recentlyViewed,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
