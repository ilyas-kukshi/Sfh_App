import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/main_banner/main_banner_model.dart';
import 'package:http/http.dart' as http;
import 'package:sfh_app/shared/constants.dart';

class DashboardService {
  Future<List<MainBannerModel>> getMainBanners() async {
    List<MainBannerModel> mainBanners = [];
    try {
      var response =
          await http.get(Uri.parse("${Constants.baseUrl}/mainBanner/get"));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var mainBanner in data["mainBanners"]) {
          mainBanners.add(MainBannerModel.fromJson(mainBanner));
        }
        return mainBanners;
      } else {
        Fluttertoast.showToast(msg: data["message"]);
        return [];
      }
    } catch (error) {
      // print(error);
      Fluttertoast.showToast(msg: error.toString());
      return [];
    }
  }
}
