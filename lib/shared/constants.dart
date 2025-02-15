import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Constants {
  static String baseUrl = "https://sfh-api-zlkq.onrender.com";
  // static String baseUrl = 'http://192.168.1.104:8080';
  static String otpUrl =
      'https://2factor.in/API/V1/a7df023c-d584-11ee-8cbb-0200cd936042/SMS';
  // static String baseUrl = 'http://192.168.205.186:8080'; // phone hotspot

  static String whatsappNumber = "919987655052";

  static String admin = "Admin";
  static String seller = "Seller";
  static String user = "User";

  static const String category = "Category";
  static const String tag = "Tag";
  static const String product = "Product";

  static String feedbackUrl = "https://forms.gle/TfaHhierhcxoRDwH6";

  static String notificationServerKey =
      "AAAAA8mMFpg:APA91bHvZy_5ZO_J3tF4tOCOueHZSf9zrkTih1nEtsM7bj8O36vVaZ6aJfvjZizyNOHcVW1qsDzCV6oPmxRNRNQG4Sa6gAXY2szKr5KZbkgKU6QvztveJifqPS_uNibKyEoN0aZbOZUa";

  static Map<String, String> colors = {
    "Black": "000000",
    "White": "FFFFFF",
    "Red": "FF0000",
    "Blue": "0000FF",
    "Green": "00FF00",
    "Yellow": "FFFF00",
    "Purple": "800080",
    "Pink": "FFC0CB",
    "Gray": "808080",
    "Brown": "A52A2A",
  };

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static String get bannerAddUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-7757893055810132/6375347834'
        : 'ca-app-pub-7757893055810132/9851558417';
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) {},
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      // print(error);
    },
    onAdOpened: (ad) {},
  );
}
