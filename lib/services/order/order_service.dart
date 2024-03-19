import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/models/order/order_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

part 'order_service.g.dart';

class OrderService {
  Future<List<OrderModel>> getMyOrders(String token) async {
    List<OrderModel> orders = [];
    try {
      var response = await http.get(Uri.parse("${Constants.baseUrl}/order/get"),
          headers: {"Authorization": "Bearer $token"});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var order in data['orders']) {
          orders.add(OrderModel.fromJson(order));
        }
        return orders;
      } else {
        Fluttertoast.showToast(msg: "Failed");
        return [];
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return [];
    }
  }
}

@Riverpod(keepAlive: true)
class OrderListNotifier extends _$OrderListNotifier {
  @override
  List<ProductModel> build() {
    return [];
  }

  void add(ProductModel product) {
    final copiedState = [...state, product];
    state = copiedState;
  }

  void clear() {
    state = [];
  }
}
