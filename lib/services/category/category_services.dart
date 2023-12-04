import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';
part 'category_services.g.dart';

class CategoryServices {
  Future<bool> addCategory(CategoryModel category, List<String> tags) async {
    try {
      // print(jsonEncode(category));
      var response = await http
          .post(Uri.parse("${Constants.baseUrl}/category/add"), body: {
        "name": category.name,
        "imageUri": category.imageUri,
        "tags": jsonEncode(tags)
      });

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

  Future<List<CategoryModel>> getAll() async {
    List<CategoryModel> categories = [];
    try {
      var response =
          await http.get(Uri.parse("${Constants.baseUrl}/category/get"));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        for (var category in data["categories"]) {
          categories.add(CategoryModel.fromJson(category));
        }
        return categories;
      }
    } catch (error) {
      print(error);
      return [];
    }
    return [];
  }
}

@riverpod
Future<List<CategoryModel>> allCategories(AllCategoriesRef ref) async {
  List<CategoryModel> categories = [];
  try {
    var response =
        await http.get(Uri.parse("${Constants.baseUrl}/category/get"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var category in data["categories"]) {
        categories.add(CategoryModel.fromJson(category));
      }
      return categories;
    }
  } catch (error) {
    print(error);
    return [];
  }
  return [];
}
