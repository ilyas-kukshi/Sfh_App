import 'package:flutter/material.dart';
import 'package:sfh_app/models/category/category_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class CategorySelection extends StatefulWidget {
  CategoryModel category;
  Function(CategoryModel) clicked;

  CategorySelection({super.key, required this.category, required this.clicked});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selected = !selected;
            widget.clicked(widget.category);
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
              widget.category.name,
              style: TextStyle(
                  fontSize: 18,
                  color: selected ? Colors.white : AppThemeShared.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
