import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/notification_service.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void initState() {
    super.initState();
    getProducts();
    getPhoneNumber();
    // createBannerAd();
    
    NotificationService().requestPermission();
    NotificationService().getDeviceToken();
    NotificationService().isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          key: globalKey,
          drawer: const DashboardDrawer(),
          appBar: AppThemeShared.appBar(
              title: "Sakina Fashion House",
              context: context,
              backButton: false,
              leading: Consumer(
                builder: (context, ref, child) {
                  if (phoneNumber != null) {
                    final user =
                        ref.watch(getUserByNumberProvider(phoneNumber!));
                    return user.value != null
                        ? user.value!.role == Constants.seller ||
                                user.value!.role == Constants.admin
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
                  } else {
                    return const Offstage();
                  }
                },
              )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final allCatgories = ref.watch(allCategoriesProvider);
                      return allCatgories.when(
                        data: (data) => SizedBox(
                          height: 172,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: allCatgories.value!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return categoryCard(allCatgories.value![index]);
                            },
                          ),
                        ),
                        error: (error, stackTrace) =>
                            Center(child: Text(error.toString())),
                        loading: () => SizedBox(
                          height: 200,
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
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Latest",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  products.isNotEmpty
                      ? GridView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 350,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            return ProductCard()
                                .productCard(products[index], context);
                          },
                        )
                      : GridView.builder(
                          itemCount: 20,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.01),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 350,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0),
                          itemBuilder: (context, index) {
                            return ProductCard().productShimmerCard(context);
                          },
                        )
                ],
              ),
            ),
          ),
        ));
  }

  Widget categoryCard(CategoryModel category) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, '/displayProductsByCategory',
      //       arguments: category);
      // },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            category.imageUri != null
                ? Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Positioned(
                        top: 15,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.green.withOpacity(0.4),
                        ),
                      ),
                      Positioned(
                        // top: 10,
                        // bottom: 40,
                        child: CachedNetworkImage(
                          height: 130,
                          width: 120,
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
            // const SizedBox(height: 2),
            Center(
                child: Text(
              category.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ))
          ],
        ),
      ),
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

  getProducts() async {
    products = await ProductServices().getLatest();
    setState(() {});
  }

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();
  }
}
