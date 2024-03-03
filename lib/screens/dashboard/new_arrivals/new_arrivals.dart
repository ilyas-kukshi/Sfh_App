import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/screens/product/product_card.dart';
import 'package:tuple/tuple.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NewArrivals extends StatefulWidget {
  const NewArrivals({super.key});

  @override
  State<NewArrivals> createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  bool isLoading = false;
  bool isLastPage = false;
  int currentPage = 0;
  List<ProductModel> products = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future<List<ProductModel>> getProducts() async {
    if (isLoading) {
      return [];
    }
    isLoading = true;
    currentPage++;
    Tuple2 data = await ProductServices().getLatest(currentPage, 10);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "New Arrivals", context: context),
      body: CustomScrollView(slivers: [
        products.isNotEmpty
            ? SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: products.length,
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: ProductCard(
                      product: products[index],
                    ),
                  ),
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 310,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0))
            : productGridShimmer(context),
        SliverToBoxAdapter(
          child: isLastPage
              ? const Offstage()
              : VisibilityDetector(
                  key: const Key("pagination"),
                  onVisibilityChanged: (info) async {
                    if (info.visibleFraction > 0.0) {
                      // print("visible now");
                      await getProducts();
                    }
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: AppThemeShared.primaryColor,
                    ),
                  )),
                ),
        )
      ]
          // products.isNotEmpty
          //     ? GridView.builder(
          //         itemCount: isLastPage ? products.length : products.length + 1,
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         padding: const EdgeInsets.symmetric(horizontal: 6),
          //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //             crossAxisCount: 2,
          //             mainAxisExtent: 304,
          //             mainAxisSpacing: 0,
          //             crossAxisSpacing: 0),
          //         itemBuilder: (context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(2.0),
          //             child: Container(
          //               // width:
          //               //     MediaQuery.of(context).size.width * 0.47,
          //               // decoration: BoxDecoration(
          //               //     border: Border.all(color: Colors.grey)),
          //               child: ProductCard(
          //                 product: products[index],
          //               ),
          //             ),
          //           );
          //         },
          //       )
          //     : productGridShimmer(context),
          ),
    );
  }

  Widget productGridShimmer(BuildContext context) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            childCount: products.length,
            (context, index) =>
                ProductShimmer().productShimmerVertical(context)),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 304,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0));

    // GridView.builder(
    //   itemCount: 20,
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 2,
    //       mainAxisExtent: 350,
    //       mainAxisSpacing: 0,
    //       crossAxisSpacing: 0),
    //   itemBuilder: (context, index) {
    //     return ProductShimmer().productShimmerVertical(context);
    //   },
    // );
  }
}
