// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String phoneNumber,
    required String password,
    @JsonKey(name: '_id') required String id,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v') required int v,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}
