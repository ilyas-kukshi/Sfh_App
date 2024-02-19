// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:sfh_app/models/category/category_model.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

TagModel tagModelFromJson(String str) => TagModel.fromJson(json.decode(str));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required String name,
    String? imageUri,
    required CategoryModel category,
    @JsonKey(name: '_id') String? id,
    int? v,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
