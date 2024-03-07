import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/models/auth/auth_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/seller_register/seller_register_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/shared/utility.dart';

part 'seller_service.g.dart';

class SellerService {
  Future<bool> register(SellerRegisterModel sellerRegister) async {
    try {
      final response = await http
          .post(Uri.parse("${Constants.baseUrl}/seller/register"), body: {
        "name": sellerRegister.name,
        "businessName": sellerRegister.businessName,
        "phoneNumber": sellerRegister.phoneNumber,
        "businessDescription": sellerRegister.businessDescription,
        "productTypes": sellerRegister.productTypes
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        return false;
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return false;
    }
    return false;
  }

  Future<bool> add(UserModel seller) async {
    try {
      var response =
          await http.post(Uri.parse("${Constants.baseUrl}/seller/add"), body: {
        "phoneNumber": seller.phoneNumber,
        "name": seller.name,
        "productLimit": jsonEncode(seller.productLimit),
        "role": "Seller",
        "categoryAccess": jsonEncode(seller.categoryAccess),
      });
      var data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Seller not created");
        return false;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Phone number not registered");
        return false;
      } else {
        Fluttertoast.showToast(msg: data["error"]);
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return false;
    }
  }

  Future<UserModel?> login(AuthModel auth) async {
    try {
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/auth/login"), body: {
        "phoneNumber": "91${auth.phoneNumber}",
        "password": auth.password
      });
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(data["user"]);
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Incorrect password");
        return null;
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "Not a seller");
        return null;
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return null;
    }
    return null;
  }

  Future<bool> moveProducts(
      List<String> products, String category, List<String> tags) async {
    try {
      String? token = await Utility().getStringSf("token");

      var response = await http
          .put(Uri.parse("${Constants.baseUrl}/seller/product/move"), headers: {
        'Authorization': 'Bearer $token'
      }, body: {
        "products": jsonEncode(products),
        "category": category,
        "tags": jsonEncode(tags)
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return false;
    }
  }
}

@riverpod
Future<List<ProductModel>> getSellerProductsByTag(
    GetSellerProductsByTagRef getSellerProductsByTagRef,
    String categoryId,
    String tagId,
    String token,
    int page) async {
  List<ProductModel> products = [];
  try {
    var response = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/seller/product/byTag?categoryId=$categoryId&tagId=$tagId&page=$page&pageSize=10"),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var product in data["products"]) {
        products.add(ProductModel.fromJson(product));
      }
      return products;
    } else {
      return [];
    }
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
    // print(error);
    return [];
  }
}
