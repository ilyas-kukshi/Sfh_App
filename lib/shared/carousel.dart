// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';
import 'package:sfh_app/shared/utility.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widget_zoom/widget_zoom.dart';

class Carousel extends StatefulWidget {
  double height;
  bool isUrl;
  List<String>? imageUrls;
  List<CroppedFile>? files;
  String? productId;
  Carousel(
      {super.key,
      required this.height,
      required this.isUrl,
      required this.files,
      required this.imageUrls,
      this.productId});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  PageController pageController = PageController();
  int currPage = 0;

  @override
  void initState() {
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
              return SizedBox(
                height: widget.height,
                child: Stack(
                  children: [
                    Center(
                      child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://img.freepik.com/free-photo/clear-empty-photographer-studio-background-abstract-background-texture-beauty-dark-light-clear-blue-cold-gray-snowy-white-gradient-flat-wall-floor-empty-spacious-room-winter-interior_1258-53070.jpg?size=626&ext=jpg&ga=GA1.1.834066242.1705652128&semt=ais"),
                    ),
                    Center(
                      child: Column(
                        children: [
                          widget.isUrl
                              ? WidgetZoom(
                                  heroAnimationTag: 't',
                                  zoomWidget: CachedNetworkImage(
                                    imageUrl: widget.imageUrls![index],
                                    height: widget.height,
                                    // width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,

                                    // color: Colors.grey.withOpacity(0.2),
                                    // color: Colors.pink,
                                    // imageBuilder: (context, imageProvider) {
                                    //   return Container(
                                    //     color: Colors.pink,
                                    //     width: MediaQuery.of(context).size.width,
                                    //     child: Image(image: imageProvider),
                                    //   );
                                    // },
                                  ))
                              : Image.file(
                                  File(widget.files![index].path),
                                  height: 250,
                                  // color: Colors.pink,
                                  fit: BoxFit.cover,
                                )
                        ],
                      ),
                    ),
                  ],
                ),
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
