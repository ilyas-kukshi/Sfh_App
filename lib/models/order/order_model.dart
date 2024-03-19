
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'dart:convert';

import 'package:sfh_app/models/user/user_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    @JsonKey(name: '_id')
     String? id,
    required UserModel user,
    required ProductModel product,
    required int price,
    required int discount,
    required String addressName,
    required String address,
    required String status,
    DateTime? createdAt,
    DateTime? updatedAt,
    @JsonKey(name: '__v')
    required int v,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
