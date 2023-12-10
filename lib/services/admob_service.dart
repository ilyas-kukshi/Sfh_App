import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/shared/constants.dart';

class AdmobService {
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7757893055810132/6375347834'
      : 'ca-app-pub-7757893055810132/9851558417';

  BannerAd createBannerAd() {
    return BannerAd(
        size: AdSize.fullBanner,
        adUnitId: Constants.bannerAddUnitId,
        listener: Constants.bannerListener,
        request: const AdRequest())
      ..load();
  }
}
