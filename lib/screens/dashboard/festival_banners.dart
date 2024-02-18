import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sfh_app/models/festival/festival_banner_model.dart';
import 'package:sfh_app/shared/app_theme_shared.dart';

class FestivalBanners extends StatefulWidget {
  final FestivalBannerModel festival;
  const FestivalBanners({super.key, required this.festival});

  @override
  State<FestivalBanners> createState() => _FestivalBannersState();
}

class _FestivalBannersState extends State<FestivalBanners> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.festival.title,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 500,
            child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0),
                children: widget.festival.tags != null
                    ? widget.festival.tags!
                        .map((tag) => Card(
                              elevation: 3,
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: tag.imageUri!,
                                    height: 170,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    tag.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontSize: 20),
                                  ),
                                ],
                              ),
                            ))
                        .toList()
                    : []),
          ),
        ],
      ),
    );
  }

  // Widget displayTags() {
  //   return widget.festival["tags"] != null
  //       ? widget.festival["tags"].forEach((tag) {
  //           return Text(tag["name"]);
  //         })
  //       : const Offstage();
  // }
}
