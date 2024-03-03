import 'package:flutter/material.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/product/product_shimmer.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/screens/product/product_card.dart';
import 'package:tuple/tuple.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DisplayProductsByTags extends StatefulWidget {
  final List<TagModel> tags;
  const DisplayProductsByTags({super.key, required this.tags});

  @override
  State<DisplayProductsByTags> createState() => _DisplayProductsByTagsState();
}

class _DisplayProductsByTagsState extends State<DisplayProductsByTags> {
  List<ProductModel> products = [];
  List<String> tagIds = [];

  bool isLastPage = false;
  bool isLoading = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Products", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            products.isNotEmpty
                ? GridView.builder(
                    itemCount: products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 301,
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
                        await getProducts();
                      }
                    },
                    child: const Center(child: CircularProgressIndicator()),
                  )
          ],
        ),
      ),
    );
  }

  getProducts() async {
    if (isLoading) {
      return [];
    }
    isLoading = true;
    if (tagIds.isEmpty) {
      for (var tag in widget.tags) {
        tagIds.add(tag.id!);
      }
    }
    Tuple2 data = await ProductServices().getByTags(tagIds, currentPage);

    if (data.item1.isNotEmpty) {
      products.addAll(data.item1);
      isLastPage = data.item2;
      isLoading = false;
      setState(() {});
    }
  }
}
