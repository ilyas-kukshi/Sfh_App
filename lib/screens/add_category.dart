import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Category", context: context),
      body: Center(
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
      bool added = await CategoryServices().addCategory(CategoryModel(
          name: name.text,
          id: 'id',
          imageUri: imageUrl,
          products: [],
          subCategories: [],
          v: 0));
    }
  }

  pickImage() async {
    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      print(file!.path);
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
          WebUiSettings(
            context: context,
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
