// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:sfh_app/models/tags/tag_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

// @freezed
// class ProductModel with _$ProductModel {
//   const factory ProductModel({
//     required Product product,
//   }) = _ProductModel;

//   factory ProductModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductModelFromJson(json);
// }

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    required List<String> imageUris,
    required String name,
    required String price,
    required String discount,
    required String category,
    required bool available,
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
