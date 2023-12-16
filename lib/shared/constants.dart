import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Constants {
  // static String baseUrl = "https://sfh-api-zlkq.onrender.com";
  static String baseUrl = 'http://192.168.1.101:8080';
  static String whatsappNumber = "919987655052";

  static String admin = "Admin";
  static String seller = "Seller";
  static String user = "User";

  static String feedbackUrl = "https://forms.gle/TfaHhierhcxoRDwH6";

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
