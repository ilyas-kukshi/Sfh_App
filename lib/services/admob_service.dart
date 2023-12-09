// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class BannerAdd extends State<BannerAd>{
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;
//   final adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-7757893055810132/6375347834'
//       : 'ca-app-pub-7757893055810132/9851558417';

//       void loadAd() {
//     _bannerAd = BannerAd(
//       adUnitId: adUnitId,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           debugPrint('$ad loaded.');
//           setState(() {
//             _isLoaded = true;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('BannerAd failed to load: $error');
//           // Dispose the ad here to free resources.
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
// }
