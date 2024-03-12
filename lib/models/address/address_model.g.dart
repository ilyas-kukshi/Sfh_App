// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddressModel _$$_AddressModelFromJson(Map<String, dynamic> json) =>
    _$_AddressModel(
      userId: json['userId'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      houseNo: json['houseNo'] as String,
      roadName: json['roadName'] as String,
      landmark: json['landmark'] as String?,
      pincode: json['pincode'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$$_AddressModelToJson(_$_AddressModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'houseNo': instance.houseNo,
      'roadName': instance.roadName,
      'landmark': instance.landmark,
      'pincode': instance.pincode,
      'city': instance.city,
      'state': instance.state,
      '_id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
