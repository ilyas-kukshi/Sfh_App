import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/category_selection.dart';
import 'package:sfh_app/shared/dialogs.dart';

class ManageProducts extends ConsumerStatefulWidget {
  const ManageProducts({super.key});

  @override
  ConsumerState<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends ConsumerState<ManageProducts> {
  List<ProductModel> products = [];
  List<String> selectedCategoryId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final allCatgories = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Manage Products", context: context),
      body: Column(
        children: [
          allCatgories.when(
              data: (data) {
                return Wrap(
                  children: data
                      .map((e) => CategorySelection(
                            category: e,
                            clicked: (category) {},
                          ))
                      .toList(),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator()),
          products.isNotEmpty
              ? GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 380,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return productCard(products[index], index);
                  },
                )
              : const CircularProgressIndicator()
        ],
      ),
    );
  }

  getProducts() async {
    products.clear();
    products = await ProductServices().getAll();
    // print("Products");
    // print(products);
    setState(() {});
  }

  Widget productCard(ProductModel product, int index) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: product.imageUris.first,
            height: 220,
            width: MediaQuery.of(context).size.width * 0.48,
            fit: BoxFit.fill,
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                "₹${product.price}",
                style: const TextStyle(
                    color: Colors.grey, decoration: TextDecoration.lineThrough),
              ),
              const SizedBox(width: 4),
              Text(
                "₹${product.price - product.discount}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              Text(
                "₹${((product.discount / product.price) * 100).toInt()}% OFF",
                style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Available:"),
              const SizedBox(width: 8),
              Switch(
                activeColor: AppThemeShared.primaryColor,
                value: product.available,
                onChanged: (value) {
                  products[index] = product.copyWith(available: value);
                  updateProduct(product.copyWith(available: value));
                  setState(() {});
                },
              )
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.48, 40),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              onPressed: () {
                Navigator.pushNamed(context, '/editProduct',
                    arguments: product);
              },
              child: Text(
                "Edit",
                style: TextStyle(color: AppThemeShared.primaryColor),
              ))
        ],
      ),
    );
  }

  updateProduct(ProductModel product) async {
    DialogShared.loadingDialog(context, "Updating");
    bool updated = await ProductServices().updateProduct(product);
    Navigator.pop(context);
    if (updated) {
      Fluttertoast.showToast(msg: "Updated");
    } else {
      Fluttertoast.showToast(msg: "Not Updated");
    }
  }
}
