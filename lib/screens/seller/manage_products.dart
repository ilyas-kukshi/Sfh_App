// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/screens/seller/manage_product_card.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/services/seller/seller_service.dart';
import 'package:sfh_app/services/tags_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/category_selection.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:sfh_app/shared/utility.dart';

class ManageProducts extends ConsumerStatefulWidget {
  final Map<String, String> filters;
  const ManageProducts({super.key, required this.filters});

  @override
  ConsumerState<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends ConsumerState<ManageProducts> {
  List<ProductModel> products = [];
  // List<String> selectedCategoryId = [];
  List<String> selectedProductIds = [];

  String? token;
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    token = await Utility().getStringSf("token");
  }

  @override
  Widget build(BuildContext context) {
    // final allCatgories = ref.watch(allCategoriesProvider);

    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: "Manage Products",
          centerTitle: false,
          context: context,
          actions: [
            selectedProductIds.isNotEmpty
                ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => MoveCategoryDialog(
                              currCategoryId: widget.filters["categoryId"]!,
                              selectedProductIds: selectedProductIds,
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.move_down,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
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
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          selectedProductIds.clear();
                        }),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                : const Offstage(),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Consumer(
                    builder: (context, ref, child) {
                      final productsProvider = ref.watch(
                          getSellerProductsByTagProvider(
                              widget.filters["categoryId"]!,
                              widget.filters["tagId"]!,
                              token!,
                              currentPage));
                      return productsProvider.when(
                        data: (products) {
                          return GridView.builder(
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
                                selected: selectedProductIds
                                    .contains(products[index].id),
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
                          );
                        },
                        error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                        loading: () => const Offstage(),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
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

class MoveCategoryDialog extends ConsumerStatefulWidget {
  final String currCategoryId;
  final List<String> selectedProductIds;
  const MoveCategoryDialog(
      {super.key,
      required this.currCategoryId,
      required this.selectedProductIds});

  @override
  ConsumerState<MoveCategoryDialog> createState() => _MoveCategoryDialogState();
}

class _MoveCategoryDialogState extends ConsumerState<MoveCategoryDialog> {
  List<TagModel> tags = [];

  CategoryModel? selectedCategory;
  String categoryName = '';
  List<TagModel> selectedTags = [];
  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(allCategoriesProvider);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Move selected Products to different Category",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CircleAvatar(child: Icon(Icons.close)))),
              ],
            ),
            const SizedBox(height: 10),
            allCategories.when(
              data: (data) {
                return AppThemeShared.sharedDropDown(
                  context: context,
                  hint: const Text('Select Category'),
                  items: data.map((e) => e.name).toList(),
                  onChanged: (value) async {
                    CategoryModel? category = getModelFromName(data, value!);
                    if (category != null) {
                      selectedCategory = category;
                      tags = await TagServices().getByCategory(category.id!);
                      setState(() {});
                    }
                  },
                );
              },
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 10),
            tags.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Select Tags",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 2,
                        runSpacing: 0,
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
                                    // print(selectedTags);
                                  },
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      AppThemeShared.sharedButton(
                        height: 45,
                        context: context,
                        buttonText: "Update",
                        onTap: () {
                          if (selectedCategory != null &&
                              selectedTags.isNotEmpty) {
                            moveProducts();
                          } else {
                            Fluttertoast.showToast(msg: "Select all fields");
                          }
                        },
                      )
                    ],
                  )
                : const Offstage(),
          ],
        ),
      ),
    );
  }

  moveProducts() async {
    bool updated = await SellerService().moveProducts(widget.selectedProductIds,
        selectedCategory!.id!, selectedTags.map((e) => e.id!).toList());

    if (updated) {
      Fluttertoast.showToast(msg: "Updated");
    }
  }

  CategoryModel? getModelFromName(List<CategoryModel> categories, String name) {
    for (CategoryModel category in categories) {
      if (category.name == name) return category;
    }
    return null;
  }
}
