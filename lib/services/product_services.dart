import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:tuple/tuple.dart';

class ProductServices {
  Future<bool> add(ProductModel product, bool asVariants) async {
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
        "asVariants": jsonEncode(asVariants),
        "tags": product.tags != null
            ? jsonEncode(product.tags!.map((e) => e.id).toList())
            : [],
        "colors": product.colors != null ? jsonEncode(product.colors) : []
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
      var response = await http.get(
        Uri.parse("${Constants.baseUrl}/product/get"),
      );
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

  Future<Tuple2> getLatest(int page) async {
    List<ProductModel> products = [];
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/latest?page=$page&pageSize=10"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var product in data["products"]) {
          products.add(ProductModel.fromJson(product));
        }
        return Tuple2(products, data["isLastPage"]);
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
    }
    return const Tuple2([], true);
  }

  Future<List<ProductModel>> getForStories(String categoryId) async {
    List<ProductModel> products = [];
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/stories?categoryId=$categoryId"));
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

  Future<ProductModel?> getById(String productId) async {
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/byId?productId=$productId"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(data["product"]);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Product Not Found");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      print(error);
    }
    return null;
  }

  Future<List<ProductModel>> getVariants(String variantId) async {
    List<ProductModel> products = [];

    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/variants?variantId=$variantId"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var product in data["products"]) {
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Product Not Found");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      print(error);
    }
    return [];
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

  Future<Tuple2> getByCategoryAndTag(
      String categoryId, List<String> tagIds, int page) async {
    List<ProductModel> products = [];
    var tags = jsonEncode(tagIds);
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/product/get/category/tags?page=$page&pageSize=10&categoryId=$categoryId&tags=$tags"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        for (var product in data["products"]) {
          products.add(ProductModel.fromJson(product));
        }
        return Tuple2(products, data["isLastPage"]);
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
    return const Tuple2([], false);
  }


  Future<bool> updateProduct(ProductModel product) async {
    try {
      var response = await http.put(
          Uri.parse("${Constants.baseUrl}/product/update?id=${product.id}"),
          body: {
            "imageUris": jsonEncode(product.imageUris.toList()),
            "seller": product.seller.id,
            "name": product.name,
            "price": jsonEncode(product.price),
            "discount": jsonEncode(product.discount),
            "category": product.category.id,
            "available": jsonEncode(product.available),
            "freeShipping": jsonEncode(product.freeShipping),
            "tags": product.tags != null
                ? jsonEncode(product.tags!.map((e) => e.id).toList())
                : [],
            "colors": product.colors != null ? jsonEncode(product.colors) : []
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

  Future<bool> delete(List<String> productIds) async {
    try {
      var response = await http.delete(
          Uri.parse("${Constants.baseUrl}/product/delete"),
          body: {"productIds": jsonEncode(productIds)});
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<dynamic> products = data["deletedProducts"];
        for (var product in products) {
          Utility().deleteImageFromRef(product["imageUris"]);
        }
        return true;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Request Error");
      } else {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
    return false;
  }
}
