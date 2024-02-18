// To parse this JSON data, do
//
//     final festivalBannerModel = festivalBannerModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:sfh_app/models/tags/tag_model.dart';

part 'festival_banner_model.freezed.dart';
part 'festival_banner_model.g.dart';

FestivalBannerModel festivalBannerModelFromJson(String str) =>
    FestivalBannerModel.fromJson(json.decode(str));

String festivalBannerModelToJson(FestivalBannerModel data) =>
    json.encode(data.toJson());

@freezed
class FestivalBannerModel with _$FestivalBannerModel {
  const factory FestivalBannerModel({
    @JsonKey(name: '_id') String? id,
    required String title,
    List<TagModel>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') int? v,
  }) = _FestivalBannerModel;

  factory FestivalBannerModel.fromJson(Map<String, dynamic> json) =>
      _$FestivalBannerModelFromJson(json);
}
