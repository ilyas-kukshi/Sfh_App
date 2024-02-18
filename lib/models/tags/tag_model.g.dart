// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TagModel _$$_TagModelFromJson(Map<String, dynamic> json) => _$_TagModel(
      name: json['name'] as String,
      imageUri: json['imageUri'] as String?,
      category: json['category'] as String,
      id: json['_id'] as String?,
      v: json['v'] as int?,
    );

Map<String, dynamic> _$$_TagModelToJson(_$_TagModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageUri': instance.imageUri,
      'category': instance.category,
      '_id': instance.id,
      'v': instance.v,
    };
