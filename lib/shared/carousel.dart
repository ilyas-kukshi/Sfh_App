import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class Carousel extends StatefulWidget {
  double height;
  bool isUrl;
  List<String>? imageUrls;
  List<CroppedFile>? files;
  Carousel(
      {super.key,
      required this.height,
      required this.isUrl,
      required this.files,
      required this.imageUrls});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController pageController = PageController();
  int currPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                widget.isUrl ? widget.imageUrls!.length : widget.files!.length,
            onPageChanged: (value) {
              setState(() {
                currPage = value;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  widget.isUrl
                      ? CachedNetworkImage(
                          imageUrl: widget.imageUrls![index],
                          height: 250,
                          // fit: BoxFit.fitHeight,
                        )
                      : Image.file(
                          File(widget.files![index].path),
                          height: 250,
                          // fit: BoxFit.scaleDown,
                        )
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        widget.imageUrls!.length == 1 || widget.files!.length == 1
            ? const Offstage()
            : Wrap(
                children: List.generate(
                    widget.isUrl
                        ? widget.imageUrls!.length
                        : widget.files!.length,
                    (index) => Container(
                          width: 20,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: currPage == index
                                  ? AppThemeShared.primaryColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppThemeShared.primaryColor)),
                        )),
              )
      ],
    );
  }
}
