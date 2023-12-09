import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class Constants {
  static String baseUrl = 'http://192.168.1.102:8080';
  static String whatsappNumber = "919987655052";

  static String removeBgApiKey = "R1saZ1RixsSshap565Lcuvb8";

  static String get bannerAddUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-7757893055810132/6375347834'
        : 'ca-app-pub-7757893055810132/9851558417';
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) {},
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print(error);
    },
    onAdOpened: (ad) {},
  );
}
