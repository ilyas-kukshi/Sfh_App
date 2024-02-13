import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/services/product_services.dart';
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

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  String? phoneNumber;

  bool isLoading = false;
  bool isLastPage = false;
  int currentPage = 0;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProducts();
    getPhoneNumber();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
    // createBannerAd();

    NotificationService().requestPermission();
    NotificationService().getDeviceToken();
    NotificationService().isTokenRefresh();
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
            appBar: AppThemeShared.appBar(
                title: "Sakina Fashion House",
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 26, color: Colors.white),
                context: context,
                backButton: false,
                leading: FutureBuilder(
                    future: getPhoneNumber(),
                    builder: (context, snapshot) {
                      return Consumer(
                        builder: (context, ref, child) {
                          if (phoneNumber != null) {
                            final user = ref
                                .watch(getUserByNumberProvider(phoneNumber!));
                            return user.when(
                              data: (data) {
                                return data != null
                                    ? data.role == Constants.seller ||
                                           data.role == Constants.admin
                                        ? GestureDetector(
                                            onTap: () {
                                              globalKey.currentState!
                                                  .openDrawer();
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
                    })),
            body: RefreshIndicator(
              displacement: 100,
              backgroundColor: AppThemeShared.primaryColor,
              color: Colors.white,
              strokeWidth: 3,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                // setState(() {
                //   products.clear();

                //   currentPage = 1;
                //   getProducts();
                // });
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
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final allCatgories = ref.watch(allCategoriesProvider);
                        return allCatgories.when(
                          data: (data) => SizedBox(
                            height: 125,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: allCatgories.value!.length,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 4),
                              itemBuilder: (context, index) {
                                categories = allCatgories.value!;
                                return categoryCard(
                                    allCatgories.value![index], index);
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Latest",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 4),
                    products.isNotEmpty
                        ? GridView.builder(
                            controller: scrollController,
                            itemCount: products.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 300,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0),
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: products[index],
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
    );
  }

  onScroll() async {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 1200) {
      currentPage++;
      await getProducts().then((value) {
        setState(() {});
      });
    }
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

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();
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
}
