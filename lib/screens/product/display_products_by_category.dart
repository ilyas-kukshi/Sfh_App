import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/product/add_products.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/services/tags_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/product_card.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:url_launcher/url_launcher.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppThemeShared.appBar(title: widget.category.name, context: context),
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
                                selected:
                                    selectedTags.contains(e.id) ? true : false,
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
                  return const CircularProgressIndicator();
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
                : const CircularProgressIndicator()
          ],
        ),
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

  enquireOnWhatsapp(ProductModel product) async {
    try {
      String whatsappUrl =
          "https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeQueryComponent('Product Images:${product.imageUris}\n Name: ${product.name},\n Price: ${product.price - product.discount}\n Discount given: ${product.discount}(${((product.discount / product.price) * 100).toInt()}%})')}";

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}
