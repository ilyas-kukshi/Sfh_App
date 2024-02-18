// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FestivalBannerModel _$$_FestivalBannerModelFromJson(
        Map<String, dynamic> json) =>
    _$_FestivalBannerModel(
      id: json['_id'] as String?,
      title: json['title'] as String,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$$_FestivalBannerModelToJson(
        _$_FestivalBannerModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
