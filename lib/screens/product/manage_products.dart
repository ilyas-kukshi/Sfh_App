// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product_service.dart';
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
  List<String> selectedProductIds = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final allCatgories = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Manage Products",
          context: context,
          actions: [
            selectedProductIds.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => DialogShared.doubleButtonDialog(
                          context,
                          "Are you sure you want to delete selected products",
                          () => deleteProduct(), () {
                        Navigator.pop(context);
                      }),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Offstage()
          ]),
      body: SingleChildScrollView(
        child: Column(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 380,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0),
                    itemBuilder: (context, index) {
                      return ManageProductCard(
                        product: products[index],
                        available: products[index].available,
                        selection: (selected, product) {
                          if (selected) {
                            selectedProductIds.add(product.id!);
                          } else {
                            selectedProductIds.remove(product.id!);
                          }
                          setState(() {});
                        },
                        availability: (available, product) {
                          products[index] =
                              product.copyWith(available: available);
                          setState(() {});
                        },
                      );
                    },
                  )
                : const CircularProgressIndicator()
          ],
        ),
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

  void refreshScreen() {
    setState(() {});
  }

  deleteProduct() async {
    bool deleted = await ProductServices().delete(selectedProductIds);
    if (deleted) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Products Deleted");
    } else {
      Fluttertoast.showToast(msg: "Not deleted");
    }
  }
}

class ManageProductCard extends StatefulWidget {
  final ProductModel product;
  final bool available;
  // bool selected;
  final Function(bool, ProductModel) availability;
  final Function(bool, ProductModel) selection;
  const ManageProductCard(
      {super.key,
      required this.product,
      required this.available,
      // required this.selected,
      required this.availability,
      required this.selection});

  @override
  State<ManageProductCard> createState() => _ManageProductCardState();
}

class _ManageProductCardState extends State<ManageProductCard> {
  bool selected = false;
  late bool available;

  @override
  void initState() {
    super.initState();
    available = widget.available;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.imageUris.first,
                height: 220,
                width: MediaQuery.of(context).size.width * 0.48,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.48,
                child: Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "₹${widget.product.price}",
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "₹${widget.product.price - widget.product.discount}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "₹${((widget.product.discount / widget.product.price) * 100).toInt()}% OFF",
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
                    value: available,
                    onChanged: (value) {
                      available = value;
                      // widget.products[index] = widget.product.copyWith(available: value);
                      updateProduct(widget.product.copyWith(available: value));
                      widget.availability(value, widget.product);
                      setState(() {});
                    },
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.48, 40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProduct',
                        arguments: widget.product);
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: AppThemeShared.primaryColor),
                  ))
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              // padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Checkbox(
                value: selected,
                side: BorderSide(width: 3, color: AppThemeShared.primaryColor),
                activeColor: AppThemeShared.primaryColor,
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                    widget.selection(value, widget.product);
                  });
                },
              ),
            ),
          )
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
