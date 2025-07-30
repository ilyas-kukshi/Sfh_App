import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const StoryPage({super.key, required this.data});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPaused = false;

  InterstitialAd? interstitialAd;

  List<ProductModel> stories = [];
  List<CategoryModel> categories = [];
  int currCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = widget.data["categories"];
    currCategoryIndex = widget.data["currCategoryIndex"];
    _pageController = PageController();

    // createInterstitialAd();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isPaused) {
        if (_currentIndex < stories.length - 1) {
          moveForward();
        } else {
          // If it reaches the last story, you can navigate to the next page or close the stories.
          if (mounted) {
            Navigator.pop(context);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    _pageController.dispose();
    if (interstitialAd != null) {
      interstitialAd!.dispose();
    }

    super.dispose();
  }

  void onTapStory(TapUpDetails tapUpDetails) {
    double tapPosition = tapUpDetails.globalPosition.dx;

    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;

    // Determine whether the tap was on the left or right side
    bool tapOnLeftSide = tapPosition < screenWidth / 2;

    if (tapOnLeftSide) {
      // Handle tap on the left side (move back)
      moveBack();
      // print('Tapped on the left side');
      // Add your logic to move back
    } else {
      // Handle tap on the right side (move ahead)
      moveForward();
      // print('Tapped on the right side');
      // Add your logic to move ahead
    }
  }

  Future<void> moveBack() async {
    // await checkForAd();

    if (_currentIndex > 0) {
      // print(_currentIndex);
      _currentIndex--;
      _pageController.previousPage(
        // _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _timer.cancel();
      _startTimer();
    }
  }

  Future<void> moveForward() async {
    // await checkForAd();
    if (_currentIndex < stories.length - 1) {
      _currentIndex++;
      _pageController.nextPage(
        // _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      if (_timer.isActive) {
        _timer.cancel();
      }

      _startTimer();
    }
    // print(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    // AdmobService().createInterstitialAd();
    return Scaffold(
        backgroundColor: const Color(0xff28282B),
        body: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: categoryCard(categories[currCategoryIndex]),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getStories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return PageView.builder(
                          controller: _pageController,
                          itemCount: stories.length,
                          itemBuilder: (context, index) {
                            ProductModel currProduct = stories[index];
                            return Column(
                              children: [
                                GestureDetector(
                                    onTapUp: (tapUpDetails) {
                                      onTapStory(tapUpDetails);
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        _isPaused = !_isPaused;
                                      });
                                    },
                                    onHorizontalDragEnd: (details) {
                                      if (details.primaryVelocity! > 0) {
                                        // Swipe right, move to the previous story
                                        if (_currentIndex > 0) {
                                          moveBack();
                                        }
                                      } else {
                                        // Swipe left, move to the next story
                                        if (_currentIndex <
                                            stories.length - 1) {
                                          moveForward();
                                        }
                                        // checkForAd();
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: currProduct.imageUris.first,
                                      height:
                                          MediaQuery.of(context).size.height -
                                              (180),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.scaleDown,
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return SizedBox(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        );
                                      },
                                    )),
                                productDetails(currProduct)
                              ],
                            );
                          },
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ));
  }

  Future<void> getStories() async {
    var fetched = await ProductServices()
        .getForStories(categories[currCategoryIndex].id!);

    if (fetched.isNotEmpty) {
      stories = [...fetched];
    }
  }

  Widget categoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        _timer.cancel();
        Navigator.pushNamed(context, '/displayProductsByCategory',
            arguments: category);
      },
      // Navigator.pushNamed(context, '/viewStory', arguments: products);

      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 50,
            imageUrl: category.imageUri!,
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(width: 8),
          Center(
              child: Text(
            category.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white),
          )),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<int?> getStoryViewCount() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getInt('storyView');
  }

  Future<void> updateStoryViewCount(int views) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt("storyView", views);
  }

  Container productDetails(ProductModel currProduct) {
    return Container(
        height: 130,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        // color: Colors.black.withOpacity(0.5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currProduct.name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20, color: Colors.white)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₹${currProduct.price}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  "₹${currProduct.price - currProduct.discount}",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.red.withOpacity(0.85), Colors.orange],
                          stops: const [1, 1],
                          tileMode: TileMode.clamp,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight)),
                  child: Text(
                    "₹${((currProduct.discount / currProduct.price) * 100).toInt()}% OFF",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.5, 40),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                onPressed: () {
                  _timer.cancel();
                  // enquireOnWhatsapp(product);
                  Navigator.pushNamed(context, '/viewProduct',
                      arguments: currProduct);
                },
                child: Text(
                  "View Product",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppThemeShared.primaryColor),
                ))
          ],
        ));
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdmobService().interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            interstitialAd = ad;
            // Keep a reference to the ad so you can show it later.
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.

                onAdImpression: (ad) {
                  // print("Impression made");
                },
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  // ad.dispose();
                  // print('Failed to load interstitial ad: $err');
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  updateStoryViewCount(0);
                  // ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // debugPrint('InterstitialAd failed to load: $error');
            // print(error.toString());
            // print(error);
            // Fluttertoast.showToast(msg: error.toString());
          },
        ));
  }
}

class StoryProgressBar extends StatelessWidget {
  final int totalDuration;
  final int currentIndex;
  final int storyIndex;

  const StoryProgressBar({
    super.key,
    required this.totalDuration,
    required this.currentIndex,
    required this.storyIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: currentIndex == storyIndex ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: currentIndex == storyIndex
              ? 0
              : MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
