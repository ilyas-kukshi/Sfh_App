import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class ColorSelection extends StatefulWidget {
  String name;
  String colorCode;
  // bool selected = false;
  Function(String) onTap;
  ColorSelection(
      {super.key,
      required this.name,
      required this.colorCode,
      // required this.selected,
      required this.onTap});

  @override
  State<ColorSelection> createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
        widget.onTap(widget.colorCode);
      }),
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
            color: Color(int.parse("0xff${widget.colorCode}")),
            shape: BoxShape.circle,
            border: Border.all(
                color:
                    selected ? AppThemeShared.primaryColor : Colors.transparent,
                width: 4)),
      ),
    );
  }
}
