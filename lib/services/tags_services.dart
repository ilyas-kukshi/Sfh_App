import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class TagServices {
  Future<List<TagModel>> getByCategory(String categoryId) async {
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
    return [];
  }
}
