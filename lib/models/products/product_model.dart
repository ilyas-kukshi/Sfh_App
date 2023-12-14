// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'dart:convert';

import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/models/user/user_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required List<String> imageUris,
    required String name,
    required int price,
    required int discount,
    required CategoryModel category,
    required bool available,
    required bool freeShipping,
    required UserModel seller,
    List<TagModel>? tags,
    int? views,
    int? enquired,
    @JsonKey(name: '_id') String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
