// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/products/product_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/models/user/user_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/services/product/product_service.dart';
import 'package:sfh_app/services/tags_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/carousel.dart';
import 'package:sfh_app/shared/color_selection.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/tag_selection.dart';
import 'package:sfh_app/shared/utility.dart';

class AddProducts extends ConsumerStatefulWidget {
  const AddProducts({super.key});

  @override
  ConsumerState<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  String? token;

  ImagePicker picker = ImagePicker();
  List<XFile> files = [];
  List<CroppedFile> croppedFiles = [];

  GlobalKey<FormState> key = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  CategoryModel? selectedCategory;
  String categoryName = '';
  List<TagModel> selectedTags = [];
  List<TagModel> tags = [];

  List<String> selectedColors = [];
  bool isFreeShipping = false;
  bool multipleColors = false;
  bool postAsVariants = false;

  @override
  void initState() {
    //
    super.initState();
    getToken();
  }

  getToken() async {
    token = await Utility().getStringSf("token");
    // print(phoneNumber);
  }

  String getDiscount() {
    double discountPercent =
        (int.parse(discount.text) / int.parse(price.text)) * 100;
    //to remove decimal point toInt is used
    return "${discountPercent.toInt()}";
  }

  String getPrice() {
    int finalPrice = int.parse(price.text) - int.parse(discount.text);
    return "$finalPrice";
  }

  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(allCategoriesProvider);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppThemeShared.appBar(title: "Add Products", context: context),
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Center(
              child: Column(
                children: [
                  // const SizedBox(height: 10),
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
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            "Product Details",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
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
                            onEditingComplete: () => setState(() {}),
                            onChanged: (p0) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          AppThemeShared.textFormField(
                            context: context,
                            hintText: "Enter discount",
                            controller: discount,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            onEditingComplete: () => setState(() {}),
                            onChanged: (p0) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          discount.text.isNotEmpty && price.text.isNotEmpty
                              ? SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Final Price: ₹${int.parse(getPrice())}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // const SizedBox(width: 4),
                                      Text(
                                        "Final Discount: ${getDiscount()}% OFF",
                                        style: const TextStyle(
                                            // color: Colors.orange,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              : const Offstage(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isFreeShipping,
                                  activeColor: AppThemeShared.primaryColor,
                                  onChanged: (value) => setState(() {
                                    isFreeShipping = !isFreeShipping;
                                  }),
                                ),
                                const Text(
                                  "Free Shipping",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: postAsVariants,
                                  activeColor: AppThemeShared.primaryColor,
                                  onChanged: (value) => setState(() {
                                    postAsVariants = !postAsVariants;
                                  }),
                                ),
                                const Text(
                                  "Post as variants",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            "Category And Tags",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
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
                                    tags = await TagServices()
                                        .getByCategory(category.id!);
                                    setState(() {});
                                  }
                                },
                              );
                            },
                            error: (error, stackTrace) =>
                                Text(error.toString()),
                            loading: () => const CircularProgressIndicator(),
                          ),
                          const SizedBox(height: 10),
                          tags.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Select Tags",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      children: tags
                                          .map((e) => TagSelection(
                                                tag: e,
                                                selected:
                                                    selectedTags.contains(e)
                                                        ? true
                                                        : false,
                                                clicked: (tag) {
                                                  if (selectedTags
                                                      .contains(tag)) {
                                                    selectedTags.remove(tag);
                                                  } else {
                                                    selectedTags.add(tag);
                                                  }
                                                  // print(selectedTags);
                                                },
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                )
                              : const Offstage(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  multipleColorsSection(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: AppThemeShared.sharedButton(
          context: context,
          width: MediaQuery.of(context).size.width * 0.85,
          buttonText: "Add Product",
          onTap: () {
            final valid = key.currentState!.validate();
            if (valid && croppedFiles.isNotEmpty && selectedCategory != null) {
              final userProfile = ref.watch(getUserByTokenProvider(token!));

              DialogShared.loadingDialog(context, 'Adding Product');
              addProduct(userProfile.value!);
            }
          },
        ),
      ),
    );
  }

  addProduct(UserModel user) async {
    List<String>? imageUrls = await Utility().uploadImages(croppedFiles);
    if (imageUrls != null) {
      bool added = await ProductServices().add(
          ProductModel(
              seller: UserModel(
                  id: user.id,
                  phoneNumber: user.phoneNumber,
                  role: user.role,
                  productLimit: user.productLimit),
              imageUris: imageUrls,
              name: name.text,
              price: int.parse(price.text),
              discount: int.parse(discount.text),
              category: selectedCategory!,
              freeShipping: isFreeShipping,
              tags: selectedTags.isNotEmpty ? selectedTags : [],
              colors: selectedColors.isNotEmpty ? selectedColors : [],
              available: true),
          postAsVariants);

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
          compressFormat: ImageCompressFormat.png,
          uiSettings: [
            AndroidUiSettings(
                cropFrameColor: Colors.transparent,
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
                backgroundColor: Colors.transparent),
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

  Widget multipleColorsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: multipleColors,
                    activeColor: AppThemeShared.primaryColor,
                    onChanged: (value) => setState(() {
                      if (value != null) {
                        multipleColors = value;
                        selectedColors.clear();
                      }
                    }),
                  ),
                  const Text(
                    "Multiple Clors Available?",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              multipleColors
                  ? Column(
                      children: [
                        const Text(
                          "Select Colors",
                          style: TextStyle(fontSize: 16),
                        ),
                        Wrap(
                          children: Constants.colors.entries
                              .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ColorSelection(
                                    name: e.key,
                                    colorCode: e.value,
                                    onTap: (colorCode) {
                                      if (selectedColors.contains(colorCode)) {
                                        selectedColors.remove(colorCode);
                                      } else {
                                        selectedColors.add(colorCode);
                                      }
                                    },
                                  )))
                              .toList(),

                          //  map((key, value) => Container(
                          //   width: 30, height: 20, color: Color(int.tryParse("0xff$value", radix: 16),),
                          // )),
                        )
                      ],
                    )
                  : const Offstage()
            ],
          ),
        ),
      ),
    );
  }
}
