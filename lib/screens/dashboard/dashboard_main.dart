import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/festival/festival_banner_model.dart';
import 'package:sfh_app/models/main_banner/main_banner_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/search_suggestions/search_suggestions_model.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/screens/dashboard/diverse_finds_banner.dart';
import 'package:sfh_app/screens/dashboard/festival_banners.dart';
import 'package:sfh_app/screens/dashboard/main_banner_carousel.dart';
import 'package:sfh_app/screens/dashboard/new_arrivals/new_arrivals_banner.dart';
import 'package:sfh_app/screens/dashboard/popular_categories_banner.dart';
import 'package:sfh_app/screens/product/product_card.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/dashboard_service.dart';
import 'package:sfh_app/services/festival_service.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/services/search_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  BannerAd? banner;

  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  TextEditingController search = TextEditingController();
  FocusNode searchFocus = FocusNode();

  List<MainBannerModel> mainBanners = [];
  List<FestivalBannerModel> festivals = [];

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<SearchSuggestionsModel> searchSuggestions = [];

  String? token;

  bool isLoading = false;
  bool isLastPage = false;
  int currentPage = 0;

  bool gettingSuggestions = false;

  @override
  void initState() {
    super.initState();

    getToken();

    getMainBanners();

    searchFocus.addListener(() {
      if (!searchFocus.hasFocus) {
        searchSuggestions.clear();
        setState(() {});
      }
    });

    // createBannerAd();

    NotificationService().requestPermission();
    NotificationService().getDeviceToken();
    NotificationService().isTokenRefresh();
  }

  getMainBanners() async {
    mainBanners = await DashboardService().getMainBanners();
  }

  Future<void> getFestivals() async {
    festivals = await FestivalService().getAll();
  }

  getToken() async {
    token = await Utility().getStringSf("token");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DialogShared.doubleButtonDialog(context, "Are you sure you to exit",
            () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          }
        }, () {
          Navigator.pop(context);
        });
        return Future.value(false);
      },
      child: SafeArea(
          top: false,
          child: Scaffold(
            key: globalKey,
            drawer: const DashboardDrawer(),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Column(
                      children: [
                        Text("Sakina Fashion House",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ],
                    ),
                    leading: drawerIcon(),
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(50),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: searchBar(),
                        )),
                    backgroundColor: AppThemeShared.primaryColor,
                    pinned: true,
                    // forceElevated: innerBoxIsScrolled,
                  ),
                ];
              },
              body: search.text.isNotEmpty
                  ? CustomScrollView(
                      slivers: [suggestionListView()],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mainBanners.isNotEmpty
                              ? MainBannerCarousel(mainBanners: mainBanners)
                              : const Offstage(),
                          const DiverseFindsBanner(),
                          FutureBuilder<void>(
                            future: getFestivals(),
                            builder: (context, snapshot) {
                              if (festivals.isEmpty) {
                                return const Offstage();
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemCount: festivals.length,
                                  itemBuilder: (context, index) =>
                                      FestivalBanners(
                                          festival: festivals[index]),
                                );
                              }
                            },
                          ),
                          const NewArrivalsBanner(),
                          const SizedBox(height: 12),
                          const PopularCategoriesBanner(),
                          const SizedBox(height: 12),
                          token != null ? recentlyViewd() : const Offstage()
                        ],
                      ),
                    ),
            ),
          )),
    );
  }

  // Widget newArrivals() {
  //   return
  // }

  Widget recentlyViewd() {
    return Consumer(
      builder: (context, ref, child) {
        final user = ref.read(getUserByTokenProvider(token!));
        return user.when(
          data: (data) {
            if (data!.recentlyViewed == null || data.recentlyViewed!.isEmpty) {
              return const Offstage();
            }
            // else if (data.recentlyViewed!.length < 5) {
            //   return const Offstage();
            // }
            else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recently Viewed",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 301,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: data.recentlyViewed!
                            .map((product) => ProductCard(product: product))
                            .toList(),
                      ),
                    )
                  ],
                ),
              );
            }
          },
          error: (error, stackTrace) => const Text("Error"),
          loading: () => const Offstage(),
        );
      },
    );
  }

  // Widget popularCategories() {
  //   return
  // }

  Widget searchBar() {
    return TextFormField(
      controller: search,
      cursorColor: Colors.white,
      style: Theme.of(context)
          .textTheme
          .labelMedium!
          .copyWith(color: Colors.white, fontSize: 16),
      onChanged: (query) async {
        Future.delayed(const Duration(milliseconds: 500));
        setState(() {
          gettingSuggestions = true;
        });
        searchSuggestions.clear();
        if (search.text.isNotEmpty) {
          searchSuggestions = await SearchService().suggestions(search.text);
        } else {
          searchSuggestions.clear();
        }
        setState(() {
          gettingSuggestions = false;
        });
      },
      decoration: InputDecoration(
          hintText: "Search for something",
          hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.white.withOpacity(
                0.5,
              ),
              fontSize: 14),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: searchSuggestions.isNotEmpty
              ? GestureDetector(
                  onTap: () => setState(() {
                    search.clear();
                    searchSuggestions.clear();
                    searchFocus.unfocus();
                  }),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              : const Offstage(),
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget drawerIcon() {
    return FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          return Consumer(
            builder: (context, ref, child) {
              if (token != null) {
                final user = ref.watch(getUserByTokenProvider(token!));
                return user.when(
                  data: (data) {
                    return data != null
                        ? data.role == Constants.seller ||
                                data.role == Constants.admin
                            ? GestureDetector(
                                onTap: () {
                                  globalKey.currentState!.openDrawer();
                                },
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              )
                            : const Offstage()
                        : const Offstage();
                  },
                  error: (error, stackTrace) => const Offstage(),
                  loading: () => const Offstage(),
                );
              } else {
                return const Offstage();
              }
            },
          );
        });
  }

  Widget suggestionListView() {
    return searchSuggestions.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
                child: gettingSuggestions
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator())
                    : const Text("We have not results matching your search")))
        : SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: searchSuggestions.length,
                (context, index) => GestureDetector(
                      onTap: () =>
                          navigateFromSuggestion(searchSuggestions[index]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getSuggestionName(searchSuggestions[index]),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(),
                                  ),
                                ),
                                Text(
                                  searchSuggestions[index].type,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                const SizedBox(width: 12),
                                const Icon(Icons.north_west)
                              ],
                            ),
                          ),
                          const Divider()
                        ],
                      ),
                    )));
  }

  navigateFromSuggestion(SearchSuggestionsModel suggestion) {
    switch (suggestion.type) {
      case Constants.category:
        Navigator.pushNamed(context, '/displayProductsByCategory',
            arguments: suggestion.category!);
        break;
      case Constants.tag:
        Navigator.pushNamed(context, '/displayProductsByTags',
            arguments: [suggestion.tag!]);
        break;
      case Constants.product:
        Navigator.pushNamed(context, '/viewProduct',
            arguments: suggestion.product);
        break;

      default:
    }
  }

  String getSuggestionName(SearchSuggestionsModel suggestion) {
    switch (suggestion.type) {
      case Constants.category:
        return suggestion.category!.name;
      case Constants.tag:
        return suggestion.tag!.name;
      case Constants.product:
        return suggestion.product!.name;

      default:
        return "Error";
    }
  }
}
