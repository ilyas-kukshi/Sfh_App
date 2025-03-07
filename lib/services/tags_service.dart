import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class TagServices {
  Future<List<TagModel>> getByCategory(String categoryId) async {
    try {
      List<TagModel> tags = [];
      var response = await http.get(Uri.parse(
          "${Constants.baseUrl}/tag/getByCategory?categoryId=$categoryId"));
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print(data);
        for (var tag in data["tags"]) {
          tags.add(TagModel.fromJson(tag));
        }
        return tags;
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: data["error"]);
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return [];
    }
    return [];
  }

  Future<bool> update(TagModel tag) async {
    try {
      var response = await http.put(
          Uri.parse("${Constants.baseUrl}/tag/update?id=${tag.id}"),
          body: {"imageUri": tag.imageUri, "name": tag.name});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return false;
    }
  }

  Future<bool> addTag(TagModel tag) async {
    try {
      var response = await http.post(Uri.parse("${Constants.baseUrl}/tag/add"),
          body: {"name": tag.name, "category": tag.category.id});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return false;
    }
  }
}
