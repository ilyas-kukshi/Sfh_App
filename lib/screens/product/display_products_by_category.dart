// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/admob_service.dart';
import 'package:sfh_app/services/product_service.dart';
import 'package:sfh_app/services/tags_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DisplayProductsByCategory extends StatefulWidget {
  CategoryModel category;
  DisplayProductsByCategory({super.key, required this.category});

  @override
  State<DisplayProductsByCategory> createState() =>
      _DisplayProductsByCategoryState();
}

class _DisplayProductsByCategoryState extends State<DisplayProductsByCategory> {
  List<TagModel> tags = [];
  List<TagModel> selectedTags = [];
  List<ProductModel> products = [];

  bool selectedTagsPopulated = false;
  bool isLoading = false;
  bool isLastPage = false;
  int currentPage = 1;

  BannerAd? banner;

  double tagFilterPosition = 0.0;
  late ScrollController tagScroller;

  @override
  void initState() {
    super.initState();
    // getProducts(widget.category.id!);
    createBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      tagScroller = ScrollController(initialScrollOffset: tagFilterPosition);
    }
    // tagScroller.animateTo(tagFilterPositionFilter,
    //     curve: Curves.easeInOut, duration: Duration(milliseconds: 500));
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppThemeShared.appBar(
            title: widget.category.name, context: context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              FutureBuilder(
                future: getTags(widget.category.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      tags = snapshot.data as List<TagModel>;
                      return SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          // runSpacing: 0,
                          // spacing: 0,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          // alignment: WrapAlignment.start,
                          controller: tagScroller,
                          children: tags
                              .map((e) => TagSelection(
                                    tag: e,
                                    selected:
                                        selectedTags.contains(e) ? true : false,
                                    clicked: (tag) {
                                      if (selectedTags.contains(tag)) {
                                        selectedTags.remove(tag);
                                      } else {
                                        selectedTags.add(tag);
                                      }
                                      currentPage = 1;
                                      products.clear();
                                      getProductsByTags(selectedTags);
                                      tagFilterPosition =
                                          tagScroller.position.pixels;
                                    },
                                  ))
                              .toList(),
                        ),
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
                              mainAxisExtent: 300,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0),
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
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
                        return ProductShimmer().productShimmerVertical(context);
                      },
                    ),
              isLastPage
                  ? const Offstage()
                  : VisibilityDetector(
                      key: const Key("pagination"),
                      onVisibilityChanged: (info) async {
                        if (info.visibleFraction > 0.0) {
                          // print("visible now");
                          currentPage++;
                          await getProductsByTags(selectedTags);
                        }
                      },
                      child: const Center(child: CircularProgressIndicator()),
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
    List<TagModel> data = [];
    data = await TagServices().getByCategory(categoryId);
    // getProductsByTags(selectedTags);

    if (!selectedTagsPopulated) {
      selectedTags = data;
      selectedTagsPopulated = true;
      getProductsByTags(selectedTags);
    }
    return data;
  }

  getProductsByTags(List<TagModel> tags) async {
    if (isLoading) {
      return [];
    }
    isLoading = true;
    List<String> selectedtagIds = [];
    for (var element in tags) {
      selectedtagIds.add(element.id!);
    }
    // DialogShared.loadingDialog(context, "Applying Filters");
    List<ProductModel> newProducts = [];
    Tuple2 data = await ProductServices()
        .getByCategoryAndTag(widget.category.id!, selectedtagIds, currentPage);
    newProducts = data.item1;
    // print(data.item2);
    isLastPage = data.item2;
    products.addAll(newProducts);
    isLoading = false;
    setState(() {});
    // Navigator.pop(context);
  }

  void createBannerAd() {
    banner = AdmobService().createBannerAd();
  }
}
