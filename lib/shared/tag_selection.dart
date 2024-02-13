// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sfh_app/models/tags/tag_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class TagSelection extends StatefulWidget {
  TagModel tag;
  Function(TagModel) clicked;
  bool selected = false;
  TagSelection(
      {super.key,
      required this.tag,
      required this.selected,
      required this.clicked});

  @override
  State<TagSelection> createState() => _TagSelectionState();
}

class _TagSelectionState extends State<TagSelection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.selected = !widget.selected;
            widget.clicked(widget.tag);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: widget.selected
                  ? AppThemeShared.primaryColor
                  : Colors.transparent,
              border: Border.all(color: AppThemeShared.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                widget.tag.name,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 16,
                      color: widget.selected
                          ? Colors.white
                          : AppThemeShared.primaryColor,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
