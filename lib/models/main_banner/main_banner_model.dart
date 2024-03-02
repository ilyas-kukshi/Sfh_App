// To parse this JSON data, do
//
//     final mainBannerModel = mainBannerModelFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'dart:convert';

import 'package:sfh_app/models/tags/tag_model.dart';

part 'main_banner_model.freezed.dart';
part 'main_banner_model.g.dart';

MainBannerModel mainBannerModelFromJson(String str) =>
    MainBannerModel.fromJson(json.decode(str));

String mainBannerModelToJson(MainBannerModel data) =>
    json.encode(data.toJson());

@freezed
class MainBannerModel with _$MainBannerModel {
  const factory MainBannerModel({
    @JsonKey(name: '_id') String? id,
    required String imageUri,
    required int position,
    List<CategoryModel>? categories,
    List<TagModel>? tags,
    List<ProductModel>? products,
    @JsonKey(name: '__v') required int v,
  }) = _MainBannerModel;

  factory MainBannerModel.fromJson(Map<String, dynamic> json) =>
      _$MainBannerModelFromJson(json);
}
