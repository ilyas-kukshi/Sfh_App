// To parse this JSON data, do
//
//     final sellerRegisterModel = sellerRegisterModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'seller_register_model.freezed.dart';
part 'seller_register_model.g.dart';

SellerRegisterModel sellerRegisterModelFromJson(String str) =>
    SellerRegisterModel.fromJson(json.decode(str));

String sellerRegisterModelToJson(SellerRegisterModel data) =>
    json.encode(data.toJson());

@freezed
class SellerRegisterModel with _$SellerRegisterModel {
  const factory SellerRegisterModel({
    required String name,
    required String businessName,
    required String phoneNumber,
    required String businessDescription,
    required String productTypes,
  }) = _SellerRegisterModel;

  factory SellerRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$SellerRegisterModelFromJson(json);
}
