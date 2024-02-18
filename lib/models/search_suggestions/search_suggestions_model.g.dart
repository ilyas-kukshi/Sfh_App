// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchSuggestionsModel _$$_SearchSuggestionsModelFromJson(
        Map<String, dynamic> json) =>
    _$_SearchSuggestionsModel(
      type: json['type'] as String,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      tag: json['tag'] == null
          ? null
          : TagModel.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SearchSuggestionsModelToJson(
        _$_SearchSuggestionsModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'product': instance.product,
      'category': instance.category,
      'tag': instance.tag,
    };
