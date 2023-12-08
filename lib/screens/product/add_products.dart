import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product_services.dart';
import 'package:sfh_app/services/tags_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:sfh_app/shared/utility.dart';

class AddProducts extends ConsumerStatefulWidget {
  const AddProducts({super.key});

  @override
  ConsumerState<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  List<TagModel> tags = [];

  ImagePicker picker = ImagePicker();
  List<XFile> files = [];
  List<CroppedFile> croppedFiles = [];

  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  CategoryModel? selectedCategory;
  String categoryName = '';
  List<TagModel> selected = [];

  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(allCategoriesProvider);
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Products", context: context),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                croppedFiles.isNotEmpty
                    ? Carousel(
                        height: 250,
                        files: croppedFiles,
                        isUrl: false,
                        imageUrls: const [],
                      )
                    : GestureDetector(
                        onTap: () => pickImage(),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppThemeShared.primaryColor,
                                  width: 3)),
                          child: Padding(
                            padding: const EdgeInsets.all(48.0),
                            child: Icon(
                              Icons.photo_library,
                              size: 40,
                              color: AppThemeShared.primaryColor,
                            ),
                          ),
                        ),
                      ),
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
                  controller: price,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                AppThemeShared.textFormField(
                  context: context,
                  hintText: "Enter discount",
                  controller: discount,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                allCategories.when(
                  data: (data) {
                    return AppThemeShared.sharedDropDown(
                      context: context,
                      hint: const Text('Select Category'),
                      items: data.map((e) => e.name).toList(),
                      onChanged: (value) async {
                        CategoryModel? category =
                            getModelFromName(data, value!);
                        if (category != null) {
                          selectedCategory = category;
                          tags =
                              await TagServices().getByCategory(category.id!);
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
                        children: [
                          Text(
                            "Select Tags",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            children: tags
                                .map((e) => TagSelection(
                                      tag: e,
                                      selected:
                                          selected.contains(e) ? true : false,
                                      clicked: (tag) {
                                        if (selected.contains(tag)) {
                                          selected.remove(tag);
                                        } else {
                                          selected.add(tag);
                                        }
                                        print(selected);
                                      },
                                    ))
                                .toList(),
                          ),
                        ],
                      )
                    : const Offstage(),
                const SizedBox(height: 10),
                AppThemeShared.sharedButton(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.85,
                  buttonText: "Add Product",
                  onTap: () {
                    final valid = key.currentState!.validate();
                    if (valid && croppedFiles.isNotEmpty) {
                      DialogShared.loadingDialog(context, 'Adding Product');
                      addProduct();
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

  addProduct() async {
    List<String>? imageUrls = await Utility().uploadImages(croppedFiles);
    if (imageUrls != null) {
      bool added = await ProductServices().add(ProductModel(
          imageUris: imageUrls,
          name: name.text,
          price: int.parse(price.text),
          discount: int.parse(discount.text),
          category: selectedCategory!,
          tags: selected.isNotEmpty ? selected : [],
          available: true));

      if (added) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Product Added");
      } else {
        Utility().deleteImageFromRef(imageUrls);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Product Not added");
      }
    }
  }

  CategoryModel? getModelFromName(List<CategoryModel> categories, String name) {
    for (CategoryModel category in categories) {
      if (category.name == name) return category;
    }
    return null;
  }

  pickImage() async {
    files = await picker.pickMultiImage();

    if (files.isNotEmpty) {
      for (var file in files) {
        CroppedFile? curr = await ImageCropper().cropImage(
          sourcePath: file.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio4x3
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        if (curr != null) {
          croppedFiles.add(curr);
        }
      }
    }
    setState(() {});
  }
}
