import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/main_banner/main_banner_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class MainBannerCarousel extends StatefulWidget {
  final List<MainBannerModel> mainBanners;
  const MainBannerCarousel({super.key, required this.mainBanners});

  @override
  State<MainBannerCarousel> createState() => _MainBannerCarouselState();
}

class _MainBannerCarouselState extends State<MainBannerCarousel> {
  int currentPage = 0;
  late Timer timer;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        if (currentPage == widget.mainBanners.length - 1) {
          currentPage = 0;
          pageController.animateToPage(currentPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          currentPage++;
          pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateTo(widget.mainBanners[currentPage]),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.mainBanners.length,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.mainBanners[index].imageUri,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 200,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppThemeShared.primaryColor, width: 2),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(12),
                          right: Radius.circular(12))),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        widget.mainBanners.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 8,
                                width: 8,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: index == currentPage
                                        ? AppThemeShared.primaryColor
                                        : AppThemeShared.secondaryColor),
                              ),
                            )),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void navigateTo(MainBannerModel mainBanner) {
    if (mainBanner.categories!.isNotEmpty) {
      Navigator.pushNamed(context, '/displayProductsByCategory',
          arguments: mainBanner.categories!.first);
    } else if (mainBanner.tags!.isNotEmpty) {
      Navigator.pushNamed(context, '/displayProductsByTags',
          arguments: mainBanner.tags);
    }
  }
}
