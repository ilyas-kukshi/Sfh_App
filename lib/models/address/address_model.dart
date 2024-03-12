// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? userId,
    required String name,
    required String phoneNumber,
    required String houseNo,
    required String roadName,
    String? landmark,
    required String pincode,
    required String city,
    required String state,
    @JsonKey(name: '_id') String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v')
    int? v,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
