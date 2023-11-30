import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/services/category_services.dart';
import 'package:sfh_app/services/tags_services.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class AddProducts extends ConsumerStatefulWidget {
  const AddProducts({super.key});

  @override
  ConsumerState<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends ConsumerState<AddProducts> {
  List<TagModel> tags = [];
  List<TagModel> selected = [];
  @override
  Widget build(BuildContext context) {
    final allCategories = ref.watch(allCategoriesProvider);
    return Scaffold(
      appBar: AppThemeShared.appBar(title: "Add Products", context: context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  context: context, hintText: "Enter name of product"),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  hintText: "Enter price", context: context),
              const SizedBox(height: 10),
              AppThemeShared.textFormField(
                  context: context, hintText: "Enter discount"),
              const SizedBox(height: 10),
              allCategories.when(
                data: (data) {
                  return AppThemeShared.sharedDropDown(
                    context: context,
                    items: data.map((e) => e.name).toList(),
                    onChanged: (value) async {
                      String categoryId = getIdFromName(data, value!);
                      if (categoryId.isNotEmpty) {
                        tags = await TagServices().getByCategory(categoryId);
                        setState(() {});
                      }
                    },
                  );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
              ),
              tags.isNotEmpty
                  ? Wrap(
                      children: tags
                          .map((e) => TagSelection(
                                tag: e,
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
                    )
                  : const Offstage(),
            ],
          ),
        ),
      ),
    );
  }

  String getIdFromName(List<CategoryModel> tags, String name) {
    for (CategoryModel category in tags) {
      if (category.name == name) return category.id!;
    }
    return '';
  }
}

class TagSelection extends StatefulWidget {
  TagModel tag;
  Function(TagModel) clicked;
  TagSelection({super.key, required this.tag, required this.clicked});

  @override
  State<TagSelection> createState() => _TagSelectionState();
}

class _TagSelectionState extends State<TagSelection> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
            widget.clicked(widget.tag);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color:
                  selected ? AppThemeShared.primaryColor : Colors.transparent,
              border: Border.all(color: AppThemeShared.primaryColor, width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              widget.tag.name,
              style: TextStyle(
                  color: selected ? Colors.white : AppThemeShared.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
