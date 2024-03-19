import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/models/auth/auth_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/shared/constants.dart';

part 'auth_service.g.dart';

class AuthService {
  Future<String?> getOtp(String phoneNumber) async {
    try {
      var response = await http
          .get(Uri.parse('${Constants.otpUrl}/+91$phoneNumber/AUTOGEN2'));

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data["OTP"];
      } else {
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return null;
    }
  }

  Future<String?> login(String phoneNumber) async {
    try {
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/auth/login?phoneNumber=$phoneNumber"));

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return data["token"];
      } else {
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
      return null;
    }
  }

  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    try {
      var respose = await http.get(
        Uri.parse(
            "${Constants.baseUrl}/user/getByNumber?phoneNumber=$phoneNumber"),
      );
      var data = jsonDecode(respose.body);

      if (respose.statusCode == 200) {
        // print("returning user");
        UserModel user = UserModel.fromJson(data["user"]);
        return user;
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
}

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
Future<UserModel?> getUserByToken(
    GetUserByTokenRef getUserByNumberRef, String token) async {
  try {
    var respose = await http
        .get(Uri.parse("${Constants.baseUrl}/user/getByToken"), headers: {
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(respose.body);

    if (respose.statusCode == 200) {
      // print("returning user");
      UserModel user = UserModel.fromJson(data["user"]);
      return user;
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
