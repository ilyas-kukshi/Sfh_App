import 'dart:convert';

import 'package:sfh_app/models/category/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class CategoryServices {
  Future<bool> addCategory(CategoryModel category) async {
    try {
      print(jsonEncode(category));
      var response = await http.post(
          Uri.parse("${Constants.baseUrl}category/add"),
          body: {"name": category.name});

      if (response.statusCode == 201) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }
}
