import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/models/address/address_model.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'address_service.g.dart';

class AddressService {
  Future<bool> addAddress(AddressModel address) async {
    try {
      String? token = await Utility().getStringSf("token");
      final response = await http.post(
        Uri.parse('${Constants.baseUrl}/address/add'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
        body: {
          "name": address.name,
          "phoneNumber": "91${address.phoneNumber}",
          "houseNo": address.houseNo,
          "roadName": address.roadName,
          "landmark": address.landmark ?? '',
          "pincode": address.pincode,
          "city": address.city,
          "state": address.state
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        Fluttertoast.showToast(msg: "Not created");
        // print('Failed to add address. Error: ${response.body}');
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      return false;
    }
  }

  Future<bool> delete(String addressId, String token) async {
    try {
      var response = await http.delete(
          Uri.parse("${Constants.baseUrl}/address/delete?addressId=$addressId"),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      return false;
    }
  }
}

@riverpod
Future<List<AddressModel>> getAddresses(
    GetAddressesRef getAddressesRef, String token) async {
  List<AddressModel> addresses = [];
  try {
    var response = await http.get(
        Uri.parse("${Constants.baseUrl}/address/getByUser"),
        headers: {"Authorization": "Bearer $token"});
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var address in data["addresses"]) {
        addresses.add(AddressModel.fromJson(address));
      }
      return addresses;
    } else {
      Fluttertoast.showToast(msg: "Not found");
      return [];
    }
  } catch (error) {
    Fluttertoast.showToast(msg: error.toString());
    return [];
  }
}
