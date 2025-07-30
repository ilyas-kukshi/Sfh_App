// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/services/tags_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class EditProduct extends ConsumerStatefulWidget {
  ProductModel product;
  EditProduct({super.key, required this.product});

  @override
  ConsumerState<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends ConsumerState<EditProduct> {
  List<TagModel> tags = [];

  ImagePicker picker = ImagePicker();
  List<XFile> files = [];
  List<CroppedFile> croppedFiles = [];
  List<String> removedImageUri = [];
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  CategoryModel? selectedCategory;
  String categoryName = '';
  List<TagModel> selected = [];

  int price = 0;
  int discount = 0;
  int sellingPrice = 0;

  @override
  void initState() {
    super.initState();
    name.text = widget.product.name;
    price = widget.product.price;
    priceController.text = widget.product.price.toString();
    discount = widget.product.discount;
    discountController.text = widget.product.discount.toString();
    categoryName = widget.product.category.name;

    if (widget.product.tags != null) {
      getTags(widget.product.category);
      for (TagModel tag in widget.product.tags!) {
        selected.add(tag);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Edit Product", context: context),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Images",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      AppThemeShared.sharedButton(
                        context: context,
                        height: 30,
                        width: 150,
                        buttonText: "Add Images",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                savedImages(),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                    context: context,
                    hintText: "Enter name of product",
                    controller: name,
                    textInputAction: TextInputAction.next,
                    validator: Utility.nameValidator),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  hintText: "Enter price",
                  context: context,
                  controller: priceController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) => setState(() {
                    price = p0.isEmpty ? 0 : int.parse(p0);
                  }),
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  context: context,
                  hintText: "Enter discount",
                  controller: discountController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onChanged: (p0) => setState(() {
                    discount = p0.isEmpty ? 0 : int.parse(p0);
                  }),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selling Price: ${price - discount}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Discount%: ${price != 0 && discount != 0 ? ((discount / price) * 100).toInt() : 0}%",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // allCategories.when(
                //   data: (data) {
                //     return AppThemeShared.sharedDropDown(
                //       context: context,
                //       value: categoryName,
                //       hint: const Text('Select Category'),
                //       items: data.map((e) => e.name).toList(),
                //       onChanged: (value) async {
                //         tags.clear();
                //         CategoryModel? category =
                //             getModelFromName(data, value!);
                //         if (category != null) {
                //           selectedCategory = category;
                //           getTags(category);
                //           setState(() {});
                //         }
                //       },
                //     );
                //   },
                //   error: (error, stackTrace) => Text(error.toString()),
                //   loading: () => const CircularProgressIndicator(),
                // ),
                // const SizedBox(height: 10),
                // tags.isNotEmpty
                //     ? Column(
                //         children: [
                //           Text(
                //             "Select Tags",
                //             style: Theme.of(context).textTheme.titleMedium,
                //           ),
                //           const SizedBox(height: 10),
                //           Wrap(
                //             children: tags
                //                 .map((e) => TagSelection(
                //                       tag: e,
                //                       selected:
                //                           selected.contains(e) ? true : false,
                //                       clicked: (tag) {
                //                         if (selected.contains(tag)) {
                //                           selected.remove(tag);
                //                         } else {
                //                           selected.add(tag);
                //                         }
                //                         // print(selected);
                //                       },
                //                     ))
                //                 .toList(),
                //           ),
                //         ],
                //       )
                //     : const Offstage(),
                const SizedBox(height: 10),
                AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Save Product",
                  onTap: () {
                    final valid = key.currentState!.validate();
                    if (valid &&
                        croppedFiles.isNotEmpty &&
                        (price - discount) > 0) {
                      DialogShared.loadingDialog(context, 'Updating Product');
                      // updateProduct(ProductModel(imageUris: imageUris, name: name, price: price, discount: discount, category: category, available: available, freeShipping: freeShipping, seller: seller));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  CategoryModel? getModelFromName(List<CategoryModel> categories, String name) {
    for (CategoryModel category in categories) {
      if (category.name == name) return category;
    }
    return null;
  }

  Future<void> updateProduct(ProductModel product) async {
    DialogShared.loadingDialog(context, "Updating");
    bool updated = await ProductServices().updateProduct(product);
    Navigator.pop(context);
    if (updated) {
      Fluttertoast.showToast(msg: "Updated");
    } else {
      Fluttertoast.showToast(msg: "Not Updated");
    }
  }

  Wrap savedImages() {
    return Wrap(
      children: widget.product.imageUris
          .map((e) => Column(
                children: [
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          height: 200,
                          width: 150,
                          imageUrl: e,
                          fit: BoxFit.fill,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppThemeShared.primaryColor,
                                  shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }

  Future<void> getTags(CategoryModel category) async {
    tags = await TagServices().getByCategory(category.id!);
    setState(() {});
  }
}
