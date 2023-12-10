import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/dashboard/bottom_nav.dart';
import 'package:sfh_app/screens/dashboard/dashboard_drawer.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/product_card.dart';

class DashboardMain extends ConsumerStatefulWidget {
  const DashboardMain({super.key});

  @override
  ConsumerState<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends ConsumerState<DashboardMain> {
  BannerAd? banner;

  GlobalKey<ScaffoldState> globalKey = GlobalKey();

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    getCategories();
    getProducts();
    // createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final allCatgories = ref.watch(allCategoriesProvider);
    return SafeArea(
        top: false,
        child: Scaffold(
          key: globalKey,
          drawer: const DashboardDrawer(),
          appBar: AppThemeShared.appBar(
              title: "Sakina Fashion House",
              context: context,
              backButton: false,
              leading: GestureDetector(
                onTap: () {
                  globalKey.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
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
                  allCatgories.when(
                    data: (data) {
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return categoryCard(data[index]);
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const CircularProgressIndicator(),
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
        child: Card(
          child: Column(
            children: [
              category.imageUri != null
                  ? CachedNetworkImage(
                      height: 130,
                      width: 120,
                      imageUrl: category.imageUri!,
                      fit: BoxFit.fill,
                      // imageBuilder: (context, imageProvider) => Container(
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           image: imageProvider, fit: BoxFit.cover)),
                      // ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : const Offstage(),
              const SizedBox(height: 10),
              Center(child: Text(category.name))
            ],
          ),
        ),
      ),
    );
  }

  Future<List<CategoryModel>> getCategories() async {
    return await CategoryServices().getAll();
    // print(categories);
  }

  getProducts() async {
    products = await ProductServices().getLatest();
    setState(() {});
  }

  
}
