import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class ViewImages extends StatefulWidget {
  List<String> imageUris;
  ViewImages({super.key, required this.imageUris});

  @override
  State<ViewImages> createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  PageController pageController = PageController();
  int currPage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.withOpacity(0.8),
          ),
          PageView.builder(
            itemCount: widget.imageUris.length,
            onPageChanged: (value) {
              setState(() {
                currPage = value;
              });
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.imageUris[index],
                fit: BoxFit.contain,
              );
            },
          ),
          widget.imageUris.length > 1
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 7, 87, 10),
                            width: 3),
                      ),
                      child: Wrap(
                        children: List.generate(
                            widget.imageUris.length,
                            (index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 20,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: currPage == index
                                            ? const Color.fromARGB(
                                                255, 7, 87, 10)
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 7, 87, 10))),
                                  ),
                                )),
                      ),
                    ),
                  ),
                )
              : const Offstage(),
        ],
      ),
    );
  }
}
