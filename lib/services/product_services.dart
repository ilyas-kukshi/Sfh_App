import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class ProductServices {
  Future<bool> add(ProductModel product) async {
    var response = await http.post(
        Uri.parse("${Constants.baseUrl}/product/add"),
        body: product.toJson());

    var data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 500) {
      Fluttertoast.showToast(msg: data["error"]);
    }
    return false;
  }

  Future<List<ProductModel>> getByCategory(String categoryId) async {
    List<ProductModel> products = [];
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/category?categoryId=$categoryId"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var product in data["products"]) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      print(error);
    }
    return products;
  }
}
