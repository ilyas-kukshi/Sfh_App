import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class ProductServices {
  Future<bool> add(ProductModel product) async {
    try {
      var response =
          await http.post(Uri.parse("${Constants.baseUrl}/product/add"), body: {
        "imageUris": jsonEncode(product.imageUris.toList()),
        "seller": product.seller.id,
        "name": product.name,
        "price": jsonEncode(product.price),
        "discount": jsonEncode(product.discount),
        "category": product.category.id,
        "freeShipping": jsonEncode(product.freeShipping),
        "tags": product.tags != null
            ? jsonEncode(product.tags!.map((e) => e.id).toList())
            : []
      });

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 500) {
        var data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: data["error"]);
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
    }
    return false;
  }

  Future<List<ProductModel>> getAll() async {
    List<ProductModel> products = [];
    try {
      var response =
          await http.get(Uri.parse("${Constants.baseUrl}/product/get"));
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
      // print(error);
    }
    return products;
  }

  Future<List<ProductModel>> getLatest() async {
    List<ProductModel> products = [];
    try {
      var response =
          await http.get(Uri.parse("${Constants.baseUrl}/product/get/latest"));
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
      // print(error);
    }
    return products;
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
      // print(error);
    }
    return products;
  }

  Future<List<ProductModel>> getByCategoryAndTag(
      String categoryId, List<String> tagIds) async {
    List<ProductModel> products = [];
    var tags = jsonEncode(tagIds);
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/category/tags?categoryId=$categoryId&tags=$tags"));
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
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
    return products;
  }

  Future<bool> updateProduct(ProductModel product) async {
    try {
      var response = await http.put(
          Uri.parse("${Constants.baseUrl}/product/update?id=${product.id}"),
          body: {
            "imageUris": jsonEncode(product.imageUris.toList()),
            "name": product.name,
            "price": jsonEncode(product.price),
            "discount": jsonEncode(product.discount),
            "category": product.category.id,
            "available": jsonEncode(product.available),
            "tags": jsonEncode(product.tags!.map((e) => e.id).toList())
          });
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Request Error");
      } else {
        var data = jsonDecode(response.body);
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
    return false;
  }
}
