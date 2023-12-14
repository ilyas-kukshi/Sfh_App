import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/auth/auth_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class SellerService {
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
      print(error);
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
      print(error);
      return null;
    }
    return null;
  }
}
