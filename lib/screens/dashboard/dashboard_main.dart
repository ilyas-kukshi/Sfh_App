import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/festival/festival_banner_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/search_suggestions/search_suggestions_model.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/screens/dashboard/festival_banners.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/festival_service.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/services/product_service.dart';
import 'package:sfh_app/services/search_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  List<FestivalBannerModel> festivals = [];
  List<SearchSuggestionsModel> searchSuggestions = [];

  String? phoneNumber;

  bool isLoading = false;
  bool isLastPage = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
    getPhoneNumber();
    getFestivals();

    // createBannerAd();

    NotificationService().requestPermission();
    NotificationService().getDeviceToken();
    NotificationService().isTokenRefresh();
  }

  getFestivals() async {
    festivals = await FestivalService().getAll();
  }

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();

    // searchFocus.addListener(() {
    //   if (!searchFocus.hasFocus) {
    //     searchSuggestions.clear();
    //     setState(() {});
    //   }
    // });
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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Column(
                  children: [
                    Text(
                      "Sakina Fashion House",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 26, color: Colors.white),
                    ),
                  ],
                ),
                leading: drawerIcon(),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: searchBar(),
                    )),
                backgroundColor: AppThemeShared.primaryColor,
                pinned: true,
                // forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
          body: SafeArea(
              top: false,
              child: Scaffold(
                key: globalKey,
                drawer: const DashboardDrawer(),
                body: searchSuggestions.isNotEmpty
                    ? CustomScrollView(
                        slivers: [suggestionListView()],
                      )
                    : RefreshIndicator(
                        displacement: 100,
                        backgroundColor: AppThemeShared.primaryColor,
                        color: Colors.white,
                        strokeWidth: 3,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        onRefresh: () async {
                          setState(() {
                            products.clear();

                            currentPage = 1;
                            getProducts();
                          });
                          return;
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Random Picks",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500)),
                              ),
                              Consumer(
                                builder: (context, ref, child) {
                                  final allCatgories =
                                      ref.watch(allCategoriesProvider);
                                  return allCatgories.when(
                                    data: (data) => SizedBox(
                                      height: 125,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: allCatgories.value!.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.only(left: 6),
                                        itemBuilder: (context, index) {
                                          categories = allCatgories.value!;
                                          return categoryCard(
                                              allCatgories.value![index],
                                              index);
                                        },
                                      ),
                                    ),
                                    error: (error, stackTrace) =>
                                        Center(child: Text(error.toString())),
                                    loading: () => SizedBox(
                                      height: 170,
                                      child: ListView.builder(
                                        itemCount:
                                            10, // You can set the number of shimmer items
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return categoryShimmerCard();
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              FutureBuilder(
                                future: getFestivals(),
                                builder: (context, snapshot) {
                                  if (festivals.isEmpty) {
                                    return const Offstage();
                                  } else {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(0),
                                      itemCount: festivals.length,
                                      itemBuilder: (context, index) =>
                                          FestivalBanners(
                                              festival: festivals[index]),
                                    );
                                  }
                                },
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text("Latest",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(height: 4),
                              products.isNotEmpty
                                  ? GridView.builder(
                                      itemCount: products.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisExtent: 304,
                                              mainAxisSpacing: 0,
                                              crossAxisSpacing: 0),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            // width:
                                            //     MediaQuery.of(context).size.width * 0.47,
                                            // decoration: BoxDecoration(
                                            //     border: Border.all(color: Colors.grey)),
                                            child: ProductCard(
                                              product: products[index],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : productGridShimmer(context),
                              isLastPage
                                  ? const Offstage()
                                  : VisibilityDetector(
                                      key: const Key("pagination"),
                                      onVisibilityChanged: (info) async {
                                        if (info.visibleFraction > 0.0) {
                                          // print("visible now");
                                          await getProducts();
                                        }
                                      },
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    )

                              // const Center(
                              //     child: Text(
                              //         "We will bring some products in this category soon!"),
                              //   )
                            ],
                          ),
                        ),
                      ),
              )),
        ));
  }

  // onScroll() async {
  //   if (scrollController.position.pixels >=
  //       scrollController.position.maxScrollExtent - 1200) {
  //     currentPage++;
  //     await getProducts().then((value) {
  //       setState(() {});
  //     });
  //   }
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
        searchSuggestions.clear();
        if (search.text.isNotEmpty) {
          searchSuggestions = await SearchService().suggestions(search.text);
        }
        setState(() {});
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
          contentPadding: EdgeInsets.all(0),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget categoryCard(CategoryModel category, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/viewStory',
            arguments: {"categories": categories, "currCategoryIndex": index});
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            category.imageUri != null
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.green, width: 2.5)),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green.withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                        // top: 10,
                        // bottom: 40,
                        child: CachedNetworkImage(
                          height: 80,
                          width: 80,
                          imageUrl: category.imageUri!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Offstage(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  )
                : const Offstage(),
            const SizedBox(height: 4),
            Center(
                child: Text(
              category.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ))
          ],
        ),
      ),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    if (isLoading) {
      return [];
    }
    isLoading = true;
    currentPage++;
    Tuple2 data = await ProductServices().getLatest(currentPage);
    // List<ProductModel> newProducts = data.item1 as List<ProductModel>;
    if (data.item1.length != 0) {
      products.addAll(data.item1);
    }

    isLastPage = data.item2;
    isLoading = false;
    // setState(() {
    //   products.addAll(newProducts);
    // });
    setState(() {});
    return products;
  }

  Widget productGridShimmer(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0),
      itemBuilder: (context, index) {
        return ProductShimmer().productShimmerVertical(context);
      },
    );
  }

  Widget categoryShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 20,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget drawerIcon() {
    return FutureBuilder(
        future: getPhoneNumber(),
        builder: (context, snapshot) {
          return Consumer(
            builder: (context, ref, child) {
              if (phoneNumber != null) {
                final user = ref.watch(getUserByNumberProvider(phoneNumber!));
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

  suggestionListView() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            childCount: searchSuggestions.length,
            (context, index) => Column(
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
                    Divider()
                  ],
                )));
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
