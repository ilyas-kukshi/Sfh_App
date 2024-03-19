// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      id: json['_id'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      price: json['price'] as int,
      discount: json['discount'] as int,
      addressName: json['addressName'] as String,
      address: json['address'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'product': instance.product,
      'price': instance.price,
      'discount': instance.discount,
      'addressName': instance.addressName,
      'address': instance.address,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
