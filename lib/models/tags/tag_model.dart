// To parse this JSON data, do
//
//     final tagModel = tagModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

TagModel tagModelFromJson(String str) => TagModel.fromJson(json.decode(str));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required String name,
    required String categoryId,
    String? id,
    int? v,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);
}
