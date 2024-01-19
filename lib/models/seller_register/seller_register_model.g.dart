// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SellerRegisterModel _$$_SellerRegisterModelFromJson(
        Map<String, dynamic> json) =>
    _$_SellerRegisterModel(
      name: json['name'] as String,
      businessName: json['businessName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      businessDescription: json['businessDescription'] as String,
      productTypes: json['productTypes'] as String,
    );

Map<String, dynamic> _$$_SellerRegisterModelToJson(
        _$_SellerRegisterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'businessName': instance.businessName,
      'phoneNumber': instance.phoneNumber,
      'businessDescription': instance.businessDescription,
      'productTypes': instance.productTypes,
    };
