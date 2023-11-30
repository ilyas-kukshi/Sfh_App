// To parse this JSON data, do
//
//     final addCategoryModel = addCategoryModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

// AddCategoryModel addCategoryModelFromJson(String str) =>
//     AddCategoryModel.fromJson(json.decode(str));

// String addCategoryModelToJson(AddCategoryModel data) =>
//     json.encode(data.toJson());

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String name,
    String? imageUri,
    List<dynamic>? subCategories,
    // List<dynamic>? tags,
    List<dynamic>? products,
    @JsonKey(name: '_id') String? id,
    int? v,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
