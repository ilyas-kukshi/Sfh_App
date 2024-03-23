import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sfh_app/models/festival/festival_banner_model.dart';
import 'package:sfh_app/shared/constants.dart';

class FestivalService {
  Future<List<FestivalBannerModel>> getAll() async {
    List<FestivalBannerModel> festivals = [];
    var response = await http
        .get(Uri.parse("https://sfh-api-zlkq.onrender.com/festival/get"));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var festival in data["festivals"]) {
        festivals.add(FestivalBannerModel.fromJson(festival));
      }
      return festivals;
    } else {
      return [];
    }
  }
}
