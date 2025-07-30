import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/search_suggestions/search_suggestions_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/shared/constants.dart';

class SearchService {
  Future<List<SearchSuggestionsModel>> suggestions(String query) async {
    
    List<SearchSuggestionsModel> suggestions = [];
    try {
      var response = await http.get(
          Uri.parse("${Constants.baseUrl}/search/suggestions?query=$query"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        for (var category in data["categories"]) {
          suggestions.add(SearchSuggestionsModel(
              type: "Category", category: CategoryModel.fromJson(category)));
        }

        for (var tag in data["tags"]) {
          suggestions.add(
              SearchSuggestionsModel(type: "Tag", tag: TagModel.fromJson(tag)));
        }

        for (var product in data["products"]) {
          suggestions.add(SearchSuggestionsModel(
              type: "Product", product: ProductModel.fromJson(product)));
        }
      }
      return suggestions;
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      // print(error);
    }
    return [];
  }
}
