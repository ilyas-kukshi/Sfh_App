import 'package:flutter/material.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/product/add_products.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/services/tags_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/tag_selection.dart';

class DisplayProductsByCategory extends StatefulWidget {
  CategoryModel category;
  DisplayProductsByCategory({super.key, required this.category});

  @override
  State<DisplayProductsByCategory> createState() =>
      _DisplayProductsByCategoryState();
}

class _DisplayProductsByCategoryState extends State<DisplayProductsByCategory> {
  List<TagModel> tags = [];
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
      body: Column(
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
                              clicked: (tag) {},
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
          )
        ],
      ),
    );
  }

  Future<List<TagModel>> getTags(String categoryId) async {
    return await TagServices().getByCategory(categoryId);
  }

  getProducts(String categoryId) async {
    products.clear();
    products = await ProductServices().getByCategory(categoryId);
    print("Products"); 
    print(products);
    setState(() {});
  }
}
