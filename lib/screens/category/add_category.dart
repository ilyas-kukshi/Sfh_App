import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/services/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class AddCategory extends StatefulWidget {
  CategoryModel? category;
  AddCategory({super.key, this.category});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  ImagePicker picker = ImagePicker();
  XFile? file;
  CroppedFile? croppedFile;

  TextEditingController name = TextEditingController();
  TextEditingController tagController = TextEditingController();

  List<String> tags = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Category", context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: CircleAvatar(
                radius: 60,
                child: Center(
                    child: croppedFile == null
                        ? const Text(
                            "Click to pick image",
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.green)),
                            child: Image.file(
                              File(croppedFile!.path),
                              fit: BoxFit.fill,
                            ),
                          )),
              ),
            ),
            const SizedBox(height: 10),
            AppThemeShared.textFormField(
                context: context, hintText: "Add name", controller: name),
            const SizedBox(height: 10),
            const Text(
              "Associated Tags",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            tags.isNotEmpty
                ? Wrap(
                    children: tags
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppThemeShared.primaryColor,
                                        width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(e),
                                      const SizedBox(width: 4),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          tags.remove(e);
                                        }),
                                        child: Icon(
                                          Icons.close,
                                          color: AppThemeShared.primaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                : const Offstage(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppThemeShared.textFormField(
                  context: context,
                  widthPercent: 0.5,
                  controller: tagController,
                ),
                const SizedBox(width: 10),
                AppThemeShared.sharedButton(
                  context: context,
                  width: 80,
                  buttonText: "Add",
                  onTap: () {
                    tags.add(tagController.text);
                    tagController.clear();
                    setState(() {});
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            AppThemeShared.sharedButton(
              context: context,
              width: MediaQuery.of(context).size.width * 0.85,
              buttonText: "Add Category",
              onTap: () {
                addCategory();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<String?> uploadPhoto() async {
    var ref = FirebaseStorage.instance.ref(name.text);

    try {
      await ref.putFile(File(croppedFile!.path));
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
      return null;
    }

    return await ref.getDownloadURL();
  }

  addCategory() async {
    String? imageUrl = await uploadPhoto();

    if (imageUrl != null) {
      bool added = await CategoryServices().addCategory(
          CategoryModel(
              name: name.text,
              id: 'id',
              imageUri: imageUrl,
              products: [],
              subCategories: [],
              v: 0),
          tags);

      if (added) {
        Fluttertoast.showToast(msg: "Category Added");
      } else {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        Fluttertoast.showToast(msg: "Category Not Added");
      }
    }
  }

  pickImage() async {
    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      // print(file!.path);
      croppedFile = await ImageCropper().cropImage(
        sourcePath: file!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
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

      setState(() {});
    }

    // final lostData = await picker.retrieveLostData();
    // if (lostData.isEmpty) {
    //   // Handle selected image
    //   print(file!.path);
    // } else {
    //   if (lostData.file != null) {
    //     // Handle the case where the user selected an image but left the app before using it
    //     print("Lost image data: ${lostData.file}");
    //   }
    // }
  }
}
