import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class Carousel extends StatefulWidget {
  List<CroppedFile> files;
  Carousel({super.key, required this.files});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController pageController = PageController();
  int currPage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.files.length,
            onPageChanged: (value) {
              setState(() {
                currPage = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.file(
                      File(widget.files[index].path),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: List.generate(
              widget.files.length,
              (index) => Container(
                    width: 20,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: currPage == index
                            ? AppThemeShared.primaryColor
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppThemeShared.primaryColor)),
                  )),
        )
      ],
    );
  }
}
