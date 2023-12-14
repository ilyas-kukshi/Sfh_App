import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/utility.dart';

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
                      return allCatgories.value != null
                          ? SizedBox(
                              height: 180,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: allCatgories.value!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return categoryCard(
                                      allCatgories.value![index]);
                                },
                              ),
                            )
                          : const Text("No Data");
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
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
                      : const CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ));
  }

  Widget categoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/displayProductsByCategory',
            arguments: category);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            category.imageUri != null
                ? CachedNetworkImage(
                    height: 130,
                    width: 120,
                    imageUrl: category.imageUri!,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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

  getProducts() async {
    products = await ProductServices().getLatest();
    setState(() {});
  }

  getPhoneNumber() async {
    phoneNumber = await Utility().getPhoneNumberSF();
  }
}
