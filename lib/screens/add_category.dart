import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/services/category_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  ImagePicker picker = ImagePicker();
  XFile? file;

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
                    child: file == null
                        ? Text(
                            "Click to pick image",
                            overflow: TextOverflow.ellipsis,
                          )
                        : CachedNetworkImage(imageUrl: file!.path)),
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

  addCategory() async {
    bool added = await CategoryServices().addCategory(CategoryModel(
        name: name.text,
        id: 'id',
        imageUri: 'id',
        products: [],
        subCategories: [],
        v: 0));
  }

  pickImage() async {
    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
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
