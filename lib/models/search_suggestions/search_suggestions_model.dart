// To parse this JSON data, do
//
//     final searchSuggestionsModel = searchSuggestionsModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'dart:convert';

import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';

part 'search_suggestions_model.freezed.dart';
part 'search_suggestions_model.g.dart';

SearchSuggestionsModel searchSuggestionsModelFromJson(String str) =>
    SearchSuggestionsModel.fromJson(json.decode(str));

String searchSuggestionsModelToJson(SearchSuggestionsModel data) =>
    json.encode(data.toJson());

@freezed
class SearchSuggestionsModel with _$SearchSuggestionsModel {
  const factory SearchSuggestionsModel({
    required String type,
    ProductModel? product,
    CategoryModel? category,
    TagModel? tag,
  }) = _SearchSuggestionsModel;

  factory SearchSuggestionsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionsModelFromJson(json);
}


