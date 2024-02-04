// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/services/tags_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:shimmer/shimmer.dart';

class DisplayProductsByCategory extends StatefulWidget {
  CategoryModel category;
  DisplayProductsByCategory({super.key, required this.category});

  @override
  State<DisplayProductsByCategory> createState() =>
      _DisplayProductsByCategoryState();
}

class _DisplayProductsByCategoryState extends State<DisplayProductsByCategory> {
  List<TagModel> tags = [];
  List<String> selectedTags = [];
  List<ProductModel> products = [];

  BannerAd? banner;
  @override
  void initState() {
    
    super.initState();
    getProducts(widget.category.id!);
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppThemeShared.appBar(
            title: widget.category.name, context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: getTags(widget.category.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      tags = snapshot.data as List<TagModel>;
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: tags
                            .map((e) => TagSelection(
                                  tag: e,
                                  selected: selectedTags.contains(e.id)
                                      ? true
                                      : false,
                                  clicked: (tag) {
                                    if (selectedTags.contains(tag.id)) {
                                      selectedTags.remove(tag.id);
                                    } else {
                                      selectedTags.add(tag.id!);
                                    }

                                    getProductsByTags(selectedTags);
                                  },
                                ))
                            .toList(),
                      );
                    } else {
                      return const Offstage();
                    }
                  } else {
                    return Wrap(
                      runSpacing: 0,
                      spacing: 0,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: List.generate(
                          6,
                          (index) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 20,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    color: Colors.grey,
                                  ),
                                ),
                              )),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
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
        bottomNavigationBar: banner != null
            ? SizedBox(height: 50, child: AdWidget(ad: banner!))
            : const Offstage(),
      ),
    );
  }

  Future<List<TagModel>> getTags(String categoryId) async {
    return await TagServices().getByCategory(categoryId);
  }

  getProducts(String categoryId) async {
    products.clear();
    products = await ProductServices().getByCategory(categoryId);
    // print("Products");
    // print(products);
    setState(() {});
  }

  getProductsByTags(List<String> tags) async {
    DialogShared.loadingDialog(context, "Applying Filters");
    products.clear();
    products =
        await ProductServices().getByCategoryAndTag(widget.category.id!, tags);
    setState(() {});
    Navigator.pop(context);
  }

  

  void createBannerAd() {
    banner = AdmobService().createBannerAd();
  }
}
