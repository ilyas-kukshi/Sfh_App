import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const StoryPage({Key? key, required this.data}) : super(key: key);

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
    getStories();
    createInterstitialAd();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (!_isPaused) {
        if (_currentIndex < stories.length - 1) {
          moveForward();
        } else {
          // If it reaches the last story, you can navigate to the next page or close the stories.
          Navigator.pop(context);
        }

        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
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

  @override
  Widget build(BuildContext context) {
    // AdmobService().createInterstitialAd();
    return SafeArea(
        child: Scaffold(
            // backgroundColor: Colors.black,
            body: stories.isNotEmpty
                ? PageView.builder(
                    controller: _pageController,
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      ProductModel currProduct = stories[index];
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: GestureDetector(
                                onTapUp: (tapUpDetails) {
                                  onTapStory(tapUpDetails);
                                },
                                onLongPress: () {
                                  setState(() {
                                    _isPaused = !_isPaused;
                                  });
                                },
                                // onLongPressCancel: ,
                                // onVerticalDragDown: (_) {
                                //   checkForAd();
                                //   Navigator.pop(context);
                                // },
                                // onLongPress: () {
                                //   setState(() {
                                //     _isPaused = !_isPaused;
                                //   });
                                // },
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity! > 0) {
                                    //check for if ad is to be shown

                                    // Swipe right, move to the previous story
                                    if (_currentIndex > 0) {
                                      moveBack();
                                    }
                                  } else {
                                    // Swipe left, move to the next story
                                    if (_currentIndex < stories.length - 1) {
                                      moveForward();
                                    }
                                    // checkForAd();
                                  }
                                },
                                child: FutureBuilder<void>(
                                  future: precacheImage(
                                    NetworkImage(currProduct.imageUris.first),
                                    context,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Image is still loading
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      // Error loading the image
                                      return const Text('Error loading image');
                                    } else {
                                      // Image loaded successfully
                                      return Image.network(
                                        currProduct.imageUris.first,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                kToolbarHeight,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      );
                                    }
                                  },
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(
                                        stories.length,
                                        (index) => StoryProgressBar(
                                          totalDuration:
                                              10, // Set the total duration for each story
                                          currentIndex: _currentIndex,
                                          storyIndex: index,
                                        ),
                                      ),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    _timer.cancel();
                                    Navigator.pushNamed(
                                        context, '/displayProductsByCategory',
                                        arguments: currProduct.category);
                                  },
                                  child: Container(
                                      height: 60,
                                      width: 200,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child:
                                          categoryCard(currProduct.category)),
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              // decoration: BoxDecoration(boxShadow: []),
                              child: productDetails(currProduct)),
                        ],
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    })
                : const Center(child: CircularProgressIndicator())));
  }

  getStories() async {
    var fetched = await ProductServices()
        .getForStories(categories[currCategoryIndex].id!);

    if (fetched.isNotEmpty) {
      stories = [...fetched];
      setState(() {});
      _startTimer();
    }
  }

  checkForAd() async {
    int? views = await getStoryViewCount();
    if (views != null) {
      if (views >= 8) {
        if (interstitialAd != null) {
          interstitialAd!.show();
          updateStoryViewCount(0);
        }
      } else {
        updateStoryViewCount(++views);
      }
    } else {
      updateStoryViewCount(1);
    }
  }

  Widget categoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/viewStory', arguments: products);
      },
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green.withOpacity(0.4),
            child: CachedNetworkImage(
              height: 30,
              width: 50,
              imageUrl: category.imageUri!,
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 8),
          Center(
              child: Text(
            category.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
          ))
        ],
      ),
    );
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
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  // ad.dispose();
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
            Fluttertoast.showToast(msg: error.toString());
          },
        ));
  }

  Future<int?> getStoryViewCount() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getInt('storyView');
  }

  updateStoryViewCount(int views) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setInt("storyView", views);
  }

  productDetails(ProductModel currProduct) {
    return Container(
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
            Text(
              currProduct.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₹${currProduct.price}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white.withOpacity(0.7),
                      decorationColor: Colors.white,
                      decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(width: 8),
                Text(
                  "₹${currProduct.price - currProduct.discount}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
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
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: AppThemeShared.primaryColor),
                ))
          ],
        ));
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

  moveBack() {
    checkForAd();
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
      _timer.cancel();
      _startTimer();

      // print(_currentIndex);
    }
  }

  moveForward() {
    checkForAd();

    setState(() {
      _currentIndex++;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    _timer.cancel();
    _startTimer();
    // print(_currentIndex);
  }
}

class StoryProgressBar extends StatelessWidget {
  final int totalDuration;
  final int currentIndex;
  final int storyIndex;

  const StoryProgressBar({
    Key? key,
    required this.totalDuration,
    required this.currentIndex,
    required this.storyIndex,
  }) : super(key: key);

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
