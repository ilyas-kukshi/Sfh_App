import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/shared/constants.dart';

class AdmobService {
  final bannerAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-7757893055810132/6375347834'
      : 'ca-app-pub-7757893055810132/9851558417';

  final interstitialAdUnitId = Platform.isAndroid
      ? "ca-app-pub-7757893055810132/8509098688"
      : "ca-app-pub-7757893055810132/5594272680";

  InterstitialAd? interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        size: AdSize.fullBanner,
        adUnitId: Constants.bannerAddUnitId,
        listener: Constants.bannerListener,
        request: const AdRequest())
      ..load();
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.b
          onAdLoaded: (ad) {
            ad.show();

            print("InterstitialAd ad loaded");
            // Keep a reference to the ad so you can show it later.
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // debugPrint('InterstitialAd failed to load: $error');
            print(error.toString());
          },
        ));
  }
}
