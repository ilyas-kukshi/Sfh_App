import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/services/auth/auth_service.dart';
import 'package:sfh_app/services/tags_service.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/constants.dart';
import 'package:sfh_app/shared/dialogs.dart';
import 'package:sfh_app/shared/utility.dart';

class ManageTags extends StatefulWidget {
  final CategoryModel category;
  const ManageTags({super.key, required this.category});

  @override
  State<ManageTags> createState() => _ManageTagsState();
}

class _ManageTagsState extends State<ManageTags> {
  List<TagModel> tags = [];
  bool addTagVisible = false;

  TextEditingController tagController = TextEditingController();

  String? token;
  Future<void> getToken() async {
    token = await Utility().getStringSf("token");
  }

  Future<void> getTags(String categoryId) async {
    tags = await TagServices().getByCategory(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemeShared.appBar(
          title: widget.category.name,
          context: context,
          actions: [
            GestureDetector(
              onTap: () => setState(() {
                addTagVisible = !addTagVisible;
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Add Tag",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white, fontSize: 16)),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addTagVisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppThemeShared.textFormField(
                        context: context,
                        hintText: "New tag name",
                        widthPercent: 0.5,
                        controller: tagController,
                      ),
                      const SizedBox(width: 10),
                      AppThemeShared.sharedButton(
                        context: context,
                        width: 80,
                        height: 55,
                        buttonText: "Add",
                        onTap: () async {
                          DialogShared.loadingDialog(context, "Adding new Tag");
                          bool added = await TagServices().addTag(TagModel(
                              name: tagController.text,
                              category: widget.category));

                          if (added) {
                            Fluttertoast.showToast(msg: "Tag added");
                          } else {
                            Fluttertoast.showToast(msg: "Tag not added");
                          }
                          tagController.clear();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      )
                    ],
                  )
                : const Offstage(),
            FutureBuilder(
                future: getTags(widget.category.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisExtent: 190),
                      children: tags
                          .map((tag) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/manageProducts', arguments: {
                                    "categoryId": widget.category.id!,
                                    "tagId": tag.id!
                                  }),
                                  child: Stack(
                                    children: [
                                      Card(
                                        child: Column(
                                          children: [
                                            tag.imageUri != null
                                                ? CachedNetworkImage(
                                                    fit: BoxFit.fill,
                                                    height: 130,
                                                    imageUrl: tag.imageUri!)
                                                : const Offstage(),
                                            const SizedBox(height: 10),
                                            Text(tag.name)
                                          ],
                                        ),
                                      ),
                                      editIcon(context, tag)
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget editIcon(BuildContext context, TagModel tag) {
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
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => UpdateTagDialog(
                                tag: tag,
                                updated: () => getTags(widget.category.id!),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.shade300,
                              child: const Icon(Icons.edit),
                            ),
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
}

class UpdateTagDialog extends StatefulWidget {
  final TagModel tag;
  final Function() updated;
  const UpdateTagDialog({super.key, required this.tag, required this.updated});

  @override
  State<UpdateTagDialog> createState() => _UpdateTagDialogState();
}

class _UpdateTagDialogState extends State<UpdateTagDialog> {
  late TextEditingController name;
  ImagePicker picker = ImagePicker();
  XFile? file;
  CroppedFile? croppedFile;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.tag.name);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 4),
                    croppedFile != null
                        ? Image.file(File(croppedFile!.path))
                        : widget.tag.imageUri == null
                            ? GestureDetector(
                                onTap: () => pickImage(),
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppThemeShared.primaryColor,
                                          width: 2)),
                                  child:
                                      const Center(child: Text("Upload Image")),
                                ),
                              )
                            : CachedNetworkImage(
                                height: 150, imageUrl: widget.tag.imageUri!),
                    const SizedBox(height: 8),
                    AppThemeShared.textFormField(
                        context: context, controller: name),
                    const SizedBox(height: 4),
                    AppThemeShared.sharedButton(
                      context: context,
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      buttonText: "Update",
                      onTap: () async {
                        if (name.text.isNotEmpty) {
                          if (croppedFile != null) {
                            String? imageUrl =
                                await Utility().uploadImage(croppedFile!);
                            updateTag(imageUrl);
                          } else {
                            updateTag(widget.tag.imageUri);
                          }
                        }
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    croppedFile = null;
                    file = null;
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateTag(String? imageUrl) async {
    bool updated = await TagServices().update(TagModel(
        id: widget.tag.id,
        imageUri: imageUrl ?? '',
        name: name.text,
        category: widget.tag.category));
    if (updated) {
      Navigator.pop(context);
      widget.updated();
    }
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
