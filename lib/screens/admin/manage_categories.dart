import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/category/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/utility.dart';

class ManageCategories extends StatefulWidget {
  const ManageCategories({super.key});

  @override
  State<ManageCategories> createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  // List<CategoryModel> categories = [];
  String? token;

  ImagePicker picker = ImagePicker();
  XFile? file;
  CroppedFile? croppedFile;

  Future<void> getToken() async {
    token = await Utility().getStringSf("token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar:
            AppThemeShared.appBar(title: "Manage Categories", context: context),
        body: Consumer(builder: (context, ref, widget) {
          final categoriesProvider = ref.watch(allCategoriesProvider);
          return categoriesProvider.when(
            data: (categories) => GridView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              // scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 190),
              itemBuilder: (context, index) {
                return categoryCard(key.currentContext!, categories[index]);
              },
            ),
            error: (error, stackTrace) => const Text("Error"),
            loading: () => const CircularProgressIndicator(),
          );
        }));
  }

  Widget categoryCard(BuildContext sContext, CategoryModel category) {
    TextEditingController name = TextEditingController(text: category.name);
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/manageTags', arguments: category),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  CachedNetworkImage(
                    height: 120,
                    width: 120,
                    imageUrl: category.imageUri!,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 10),
                  Center(child: Text(category.name))
                ],
              ),
            ),
          ),
          editIcon(category, name)
        ],
      ),
    );
  }

  Widget editIcon(CategoryModel category, TextEditingController name) {
    return FutureBuilder(
        future: getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer(builder: (context, ref, child) {
              final user = ref.watch(getUserByTokenProvider(token!));

              return user.when(
                data: (data) {
                  return data!.role == Constants.user
                      ? const Offstage()
                      : Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              editDialog(category, name);
                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(Icons.edit)),
                          ),
                        );
                },
                error: (error, stackTrace) {
                  return Center(child: Text(error.toString()));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void editDialog(CategoryModel category, TextEditingController name) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => pickImage(),
                          child: croppedFile != null
                              ? Image.file(height: 150, File(croppedFile!.path))
                              : CachedNetworkImage(
                                  height: 150,
                                  imageUrl: category.imageUri!,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        const SizedBox(height: 10),
                        AppThemeShared.textFormField(
                            context: context, controller: name),
                        AppThemeShared.sharedButton(
                          context: context,
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          buttonText: "Update",
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        child: GestureDetector(
                            onTap: () {
                              croppedFile = null;
                              file = null;
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> pickImage() async {
    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      // print(file!.path);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: file!.path,
        compressFormat: ImageCompressFormat.png,
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

      setState(() {});
    }
  }
}
