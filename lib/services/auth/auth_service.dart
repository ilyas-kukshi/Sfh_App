import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/models/auth/auth_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

part 'auth_service.g.dart';

class AuthService {}

@riverpod
Future<bool> signIn(SignInRef signInRef, AuthModel auth) async {
  try {
    var response = await http.post(Uri.parse("${Constants.baseUrl}/auth/login"),
        body: {
          "phoneNumber": "91${auth.phoneNumber}",
          "password": auth.password
        });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: "Incorrect password");
      return false;
    } else if (response.statusCode == 404) {
      Fluttertoast.showToast(msg: "Not a seller");
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

@riverpod
Future<UserModel?> getUserByNumber(
    GetUserByNumberRef getUserByNumberRef, String phoneNumber) async {
  try {
    var respose = await http.get(Uri.parse(
        "${Constants.baseUrl}/user/getByNumber?phoneNumber=$phoneNumber"));
    var data = jsonDecode(respose.body);

    if (respose.statusCode == 200) {
      print("returning user");
      return UserModel.fromJson(data["user"]);
    } else if (respose.statusCode == 404) {
      return null;
    } else if (respose.statusCode == 500) {
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
